require('conform').setup({
    formatters_by_ft = {
        lua = { 'stylua' },
        c = { 'clang-format' },
        cpp = { 'clang-format' },
        go = { 'gofmt' },
        rust = { 'rustfmt' },
        python = { 'isort', 'black' },
        javascript = { 'prettier' },
        typescript = { 'prettier' },
        svelte = { 'prettier' },
        html = { 'prettier' },
        css = { 'prettier' },
        json = { 'prettier' },
        yaml = { 'prettier' },
        markdown = { 'prettier' },
        typst = { 'typstfmt' },
    },
    default_format_opts = { lsp_format = 'fallback' },
})

-- Manual format (kept on <leader>f from the previous config).
vim.keymap.set({ 'n', 'v' }, '<leader>f', function()
    require('conform').format({ async = true, lsp_format = 'fallback' })
end, { desc = 'Format buffer' })
