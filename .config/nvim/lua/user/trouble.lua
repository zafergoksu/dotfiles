require('trouble').setup({})

local map = vim.keymap.set

map('n', '<leader>xx', '<cmd>Trouble diagnostics toggle<cr>', { desc = 'Diagnostics (Trouble)' })
map('n', '<leader>xX', '<cmd>Trouble diagnostics toggle filter.buf=0<cr>', { desc = 'Buffer diagnostics (Trouble)' })
map('n', '<leader>xs', '<cmd>Trouble symbols toggle focus=false<cr>', { desc = 'Symbols (Trouble)' })
map('n', '<leader>xl', '<cmd>Trouble lsp toggle focus=false win.position=right<cr>', { desc = 'LSP defs/refs (Trouble)' })
map('n', '<leader>xL', '<cmd>Trouble loclist toggle<cr>', { desc = 'Location list (Trouble)' })
map('n', '<leader>xQ', '<cmd>Trouble qflist toggle<cr>', { desc = 'Quickfix list (Trouble)' })
