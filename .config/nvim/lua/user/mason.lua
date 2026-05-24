require('mason').setup({
    ui = {
        border = 'rounded',
        icons = {
            package_installed = '✓',
            package_pending = '➜',
            package_uninstalled = '✗',
        },
    },
})

-- Auto-install formatters / tools (codelldb is handled by mason-nvim-dap).
require('mason-tool-installer').setup({
    ensure_installed = {
        'clang-format',
        'stylua',
        'prettier',
        'tree-sitter-cli',
    },
})
