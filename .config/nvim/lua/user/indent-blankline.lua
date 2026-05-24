require('ibl').setup({
    indent = { char = '│' },
    scope = { enabled = true, show_start = false, show_end = false },
    exclude = {
        filetypes = {
            'help',
            'NvimTree',
            'mason',
            'lazy',
            'dashboard',
            'trouble',
            'toggleterm',
        },
    },
})
