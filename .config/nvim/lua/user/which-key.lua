local wk = require('which-key')

-- Popup is off by default; <leader>uk flips this (see keybinds.lua).
vim.g.which_key_enabled = false

wk.setup({
    preset = 'modern',
    win = { border = 'rounded' },
    -- delay is re-evaluated on every keypress, so flipping the flag
    -- takes effect immediately without re-running setup().
    delay = function()
        return vim.g.which_key_enabled and 200 or 1000000000
    end,
})

-- Group labels for the leader-prefixed keymaps defined across the config.
wk.add({
    { '<leader>b', group = 'Buffers' },
    { '<leader>c', group = 'Code / C++' },
    { '<leader>d', group = 'Debug' },
    { '<leader>g', group = 'Git' },
    { '<leader>h', group = 'Harpoon' },
    { '<leader>m', group = 'CMake' },
    { '<leader>p', group = 'Pick (Telescope)' },
    { '<leader>t', group = 'Terminal' },
    { '<leader>u', group = 'UI toggles' },
    { '<leader>x', group = 'Trouble / Diagnostics' },
    { '<leader>G', group = 'Godbolt (Compiler Explorer)' },
})
