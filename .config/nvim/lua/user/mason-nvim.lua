local function desc(description)
    return { noremap = true, silent = true, buffer = bufnr, desc = description }
end

local augroup = vim.api.nvim_create_augroup('LspFormatting', {})
local function lsp_format(client, bufnr)
    vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
    vim.api.nvim_create_autocmd('BufWritePre', {
        group = augroup,
        buffer = bufnr,
        callback = function()
            vim.lsp.buf.format()
        end,
    })
end

local function make_on_attach(server_name)
    return function(client, bufnr)
        local function buf_set_keymap(...)
            vim.api.nvim_buf_set_keymap(bufnr, ...)
        end

        local opts = { noremap = true, silent = true }
        vim.lsp.inlay_hint.enable(false, nil, bufnr)
        vim.keymap.set('n', '<leader>h', function()
            local current_setting = vim.lsp.inlay_hint.is_enabled(nil, bufnr)
            vim.lsp.inlay_hint.enable(not current_setting, nil, bufnr)
        end, desc('[lsp] toggle inlay hints'))

        if server_name == "ts_ls" then
            client.server_capabilities.document_formatting = false
        end
        lsp_format(client, bufnr)
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
    ensure_installed = { "clangd", "dockerls", "bashls", "cmake", "cssls", "gopls",
        "html", "jsonls", "ts_ls", "pyright", "svelte", "taplo", "tailwindcss", "zls", "yamlls" }
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

    ["ts_ls"] = function()
        require("lspconfig")["ts_ls"].setup({
            on_attach = make_on_attach("ts_ls"),
            capabilities = make_capabilities(),
            filetypes = { "javascript", "typescript", "typescriptreact", "typescript.tsx" },
        })
    end,

    ["clangd"] = function()
        require("lspconfig")["clangd"].setup({
            on_attach = make_on_attach("clangd"),
            capabilities = make_capabilities(),
            settings = {
                cmd = {
                    "clangd",
                    "--all-scopes-completion",
                    "--background-index",
                    "--clang-tidy"
                }
            }
        })
    end
}

vim.g.rustaceanvim = function()
    local extension_path = vim.env.HOME .. '.local/share/nvim/mason/packages/codelldb/extension/'
    local codelldb_path = extension_path .. 'adapter/codelldb'
    local liblldb_path = extension_path .. 'lldb/lib/liblldb'
    local this_os = vim.uv.os_uname().sysname;

    -- The path is different on Windows
    if this_os:find "Windows" then
        codelldb_path = extension_path .. "adapter\\codelldb.exe"
        liblldb_path = extension_path .. "lldb\\bin\\liblldb.dll"
    else
        -- The liblldb extension is .so for Linux and .dylib for MacOS
        liblldb_path = liblldb_path .. (this_os == "Linux" and ".so" or ".dylib")
    end

    local cfg = require('rustaceanvim.config')

    return {
        server = {
            on_attach = function(client, bufnr)
                if client.server_capabilities.inlayHintProvider then
                    vim.lsp.inlay_hint.enable(false, nil, bufnr)
                    vim.keymap.set('n', '<leader>h', function()
                        local current_setting = vim.lsp.inlay_hint.is_enabled(nil, bufnr)
                        vim.lsp.inlay_hint.enable(not current_setting, nil, bufnr)
                    end, desc('[lsp] toggle inlay hints'))
                end
            end,
            default_settings = {
                -- rust-analyzer language server configuration
                ['rust-analyzer'] = {
                },
            },
        },
        dap = {
            adapter = cfg.get_codelldb_adapter(codelldb_path, liblldb_path),
        },
    }
end
