require('render-markdown').setup({})

vim.keymap.set('n', '<leader>um', '<cmd>RenderMarkdown toggle<cr>', { desc = 'Toggle markdown render' })
