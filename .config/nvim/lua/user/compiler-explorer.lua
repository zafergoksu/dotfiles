require('compiler-explorer').setup({})

local map = vim.keymap.set

map('n', '<leader>Gc', '<cmd>CECompile<cr>', { desc = 'Compile' })
map('v', '<leader>Gc', ':CECompile<cr>', { desc = 'Compile selection' })
map('n', '<leader>GC', '<cmd>CECompileLive<cr>', { desc = 'Compile live' })
map('n', '<leader>Gf', '<cmd>CEFormat<cr>', { desc = 'Format' })
map('n', '<leader>Gl', '<cmd>CEAddLibrary<cr>', { desc = 'Add library' })
map('n', '<leader>Ge', '<cmd>CELoadExample<cr>', { desc = 'Load example' })
map('n', '<leader>Go', '<cmd>CEOpenWebsite<cr>', { desc = 'Open in browser' })
map('n', '<leader>Gt', '<cmd>CEShowTooltip<cr>', { desc = 'Show tooltip' })
map('n', '<leader>Gg', '<cmd>CEGotoLabel<cr>', { desc = 'Goto label' })
