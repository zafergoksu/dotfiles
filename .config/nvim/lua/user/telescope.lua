require('telescope').setup({})
local telescope_builtin = require('telescope.builtin')

vim.keymap.set('n', '<C-p>', telescope_builtin.find_files, { desc = 'Telescope find files' })
