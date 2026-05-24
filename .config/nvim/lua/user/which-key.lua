local wk = require('which-key')

wk.setup({
    preset = 'modern',
    win = { border = 'rounded' },
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
    { '<leader>T', group = 'Tests' },
})
