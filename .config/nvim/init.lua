vim.pack.add({
    { src = 'https://github.com/vague2k/vague.nvim' },
    { src = 'https://github.com/nvim-tree/nvim-tree.lua' },
    { src = 'https://github.com/nvim-telescope/telescope.nvim' },
    { src = 'https://github.com/neovim/nvim-lspconfig' },
    { src = 'https://github.com/chomosuke/typst-preview.nvim' },
    { src = 'https://github.com/nvim-treesitter/nvim-treesitter', version = 'main' },
    { src = 'https://github.com/mason-org/mason.nvim' },
    { src = 'https://github.com/hrsh7th/nvim-cmp' },
    { src = 'https://github.com/Shatur/neovim-ayu' },
    { src = 'https://github.com/morhetz/gruvbox' },
    { src = 'https://github.com/blazkowolf/gruber-darker.nvim' },
    { src = 'https://github.com/idr4n/github-monochrome.nvim' },
    { src = 'https://github.com/lewis6991/gitsigns.nvim' },
    { src = 'https://github.com/nvim-tree/nvim-web-devicons' },
    { src = 'https://github.com/akinsho/bufferline.nvim' },
    { src = 'https://github.com/m4xshen/autoclose.nvim' }
})

require('user.options')
require('user.keybinds')
require('user.cmp')
require('user.nvim-tree')
require('user.nvim-treesitter')
require('user.telescope')

require('mason').setup()
require('bufferline').setup({})
require("autoclose").setup({})

