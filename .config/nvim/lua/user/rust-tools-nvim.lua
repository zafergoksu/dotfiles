local lsp_status = require("lsp-status")
lsp_status.register_progress()

local extension_path = vim.env.HOME .. '/.local/share/nvim/mason/packages/codelldb/extension/'
local codelldb_path = extension_path .. 'adapter/codelldb'
local liblldb_path = extension_path .. 'lldb/lib/liblldb.so'

local function lsp_format(client)
    if client.server_capabilities.document_formatting then
        vim.api.nvim_exec(
            [[
            augroup Format
            autocmd! * <buffer>
            autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_seq_sync()
            augroup END
        ]]   ,
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

        buf_set_keymap("n", "K", "<cmd>RustHoverActions<CR>", opts)
        buf_set_keymap("n", "<leader>ff", "<cmd>RustFmt<CR>", opts)
        buf_set_keymap("n", "gJ", "<cmd>RustJoinLines<CR>", opts)

        lsp_format(client)
    end
end

local function make_capabilities()
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
    capabilities = vim.tbl_extend("keep", capabilities, require("lsp-status").capabilities)

    return capabilities
end

local rust_tools_opts = {
    tools = {
        autoSetHints = true,
        hover_with_actions = false,
    },
    -- all the opts to send to nvim-lspconfig
    -- these override the defaults set by rust-tools.nvim
    -- see https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md#rust_analyzer
    server = {
        on_attach = make_on_attach(),
        capabilities = make_capabilities(),
        settings = {
            -- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
            ["rust-analyzer"] = {
                assist = {
                    importPrefix = "by_self",
                },
                cargo = {
                    allFeatures = true,
                },
                checkOnSave = {
                    command = "clippy",
                },
                lens = {
                    references = true,
                    methodReferences = true,
                },
            },
        },
    },

    dap = {
        adapter = require('rust-tools.dap').get_codelldb_adapter(
            codelldb_path, liblldb_path)
    }
}

return {
    setup = rust_tools_opts
}
