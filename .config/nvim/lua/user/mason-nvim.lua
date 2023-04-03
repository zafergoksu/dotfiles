local function lsp_format(client)
    if client.server_capabilities.document_formatting then
        vim.api.nvim_exec(
            [[
            augroup Format
            autocmd! * <buffer>
            autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_seq_sync()
            augroup END
        ]],
            false
        )
    end
end

local function make_on_attach(server_name)
    return function(client, bufnr)
        local function buf_set_keymap(...)
            vim.api.nvim_buf_set_keymap(bufnr, ...)
        end

        local opts = { noremap = true, silent = true }

        if server_name == "rust_analyzer" then
            buf_set_keymap("n", "K", "<cmd>RustHoverActions<CR>", opts)
        else
            buf_set_keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
        end
        if server_name == "rust_analyzer" then
            buf_set_keymap("n", "<leader>ff", "<cmd>RustFmt<CR>", opts)
        else
            buf_set_keymap("n", "<leader>ff", "<cmd> lua vim.lsp.buf.formatting()<CR>", opts)
        end
        if server_name == "rust_analyzer" then
            buf_set_keymap("n", "gJ", "<cmd>RustJoinLines<CR>", opts)
        end
        if server_name == "tsserver" then
            client.server_capabilities.document_formatting = false
        end
        lsp_format(client)
    end
end

local function make_capabilities()
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
    capabilities = vim.tbl_extend("keep", capabilities, require("lsp-status").capabilities)

    return capabilities
end

require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = { "rust_analyzer", "clangd", "dockerls", "bashls", "cmake", "cssls", "gopls",
        "html", "jsonls", "tsserver", "pyright", "svelte", "taplo", "tailwindcss", "zls", "yamlls" }
})

require("mason-lspconfig").setup_handlers {
    -- The first entry (without a key) will be the default handler
    -- and will be called for each installed server that doesn't have
    -- a dedicated handler.
    function(server_name) -- default handler (optional)
        require("lspconfig")[server_name].setup({
            on_attach = make_on_attach(server_name),
            capabilities = make_capabilities()
        })
    end,
    -- Next, you can provide targeted overrides for specific servers.
    -- For example, a handler override for the `rust_analyzer`:
    ["rust_analyzer"] = function()
        require("rust-tools").setup(require("user.rust-tools-nvim").setup)
    end,

    ["tsserver"] = function()
        require("lspconfig")["tsserver"].setup({
            on_attach = make_on_attach("tsserver"),
            capabilities = make_capabilities(),
            filetypes = { "javascript", "typescript", "typescriptreact", "typescript.tsx" },
        })
    end
}
