local todo = require('todo-comments')
todo.setup({})

local map = vim.keymap.set

map('n', ']t', function() todo.jump_next() end, { desc = 'Next todo comment' })
map('n', '[t', function() todo.jump_prev() end, { desc = 'Prev todo comment' })
map('n', '<leader>xt', '<cmd>Trouble todo toggle<cr>', { desc = 'Todo (Trouble)' })
map('n', '<leader>pt', '<cmd>TodoTelescope<cr>', { desc = 'Todo (Telescope)' })
