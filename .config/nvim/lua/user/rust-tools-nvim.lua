local lsp_status = require("lsp-status")
lsp_status.register_progress()

local rust_tools_opts = {
    tools = {
        autoSetHints = true,
        hover_with_actions = false,
    },
    -- all the opts to send to nvim-lspconfig
    -- these override the defaults set by rust-tools.nvim
    -- see https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md#rust_analyzer
    server = {
        on_attach = require("user.lsp.init").make_on_attach("rust_analyzer"),
        capabilities = require("user.lsp.init").make_capabilities(),
        settings = {
            -- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
            ["rust-analyzer"] = {
                assist = {
                    importPrefix = "by_self",
                },
                cargo = {
                    allFeatures = true,
                },
                -- checkOnSave = {
                --     command = "clippy",
                -- },
                lens = {
                    references = true,
                    methodReferences = true,
                },
            },
        },
    },
}

require("rust-tools").setup(rust_tools_opts)
