require('clangd_extensions').setup({
    inlay_hints = {
        inline = false, -- use built-in lsp inlay hints instead
    },
    ast = {
        role_icons = {
            type = '',
            declaration = '',
            expression = '',
            specifier = '',
            statement = '',
            ['template argument'] = '',
        },
        kind_icons = {
            Compound = '',
            Recover = '',
            TranslationUnit = '',
            PackExpansion = '',
            TemplateTypeParm = '',
            TemplateTemplateParm = '',
            TemplateParamObject = ''
        },
    },
    memory_usage = { border = 'rounded' },
    symbol_info = { border = 'rounded' },
})

-- C++ specific keymaps (only meaningful when clangd is attached)
vim.api.nvim_create_autocmd('FileType', {
    pattern = { 'c', 'cpp', 'objc', 'objcpp' },
    callback = function(ev)
        vim.keymap.set('n', '<leader>ch', '<cmd>ClangdSwitchSourceHeader<cr>',
            { buffer = ev.buf, desc = 'Switch source/header' })
        vim.keymap.set('n', '<leader>cs', '<cmd>ClangdSymbolInfo<cr>',
            { buffer = ev.buf, desc = 'Clangd symbol info' })
        vim.keymap.set('n', '<leader>ct', '<cmd>ClangdTypeHierarchy<cr>',
            { buffer = ev.buf, desc = 'Clangd type hierarchy' })
        vim.keymap.set('n', '<leader>cm', '<cmd>ClangdMemoryUsage<cr>',
            { buffer = ev.buf, desc = 'Clangd memory usage' })
    end,
})
