vim.pack.add({
    -- Colorschemes
    { src = 'https://github.com/blazkowolf/gruber-darker.nvim' },
    { src = 'https://github.com/vague2k/vague.nvim' },
    { src = 'https://github.com/Shatur/neovim-ayu' },
    { src = 'https://github.com/morhetz/gruvbox' },
    { src = 'https://github.com/idr4n/github-monochrome.nvim' },

    -- UI
    { src = 'https://github.com/nvim-tree/nvim-web-devicons' },
    { src = 'https://github.com/nvim-tree/nvim-tree.lua' },
    { src = 'https://github.com/akinsho/bufferline.nvim' },
    { src = 'https://github.com/folke/which-key.nvim' },

    -- Telescope
    { src = 'https://github.com/nvim-lua/plenary.nvim' },
    { src = 'https://github.com/nvim-telescope/telescope.nvim' },

    -- LSP & Completion
    { src = 'https://github.com/neovim/nvim-lspconfig' },
    { src = 'https://github.com/mason-org/mason.nvim' },
    { src = 'https://github.com/hrsh7th/nvim-cmp' },
    { src = 'https://github.com/hrsh7th/cmp-nvim-lsp' },
    { src = 'https://github.com/hrsh7th/cmp-buffer' },
    { src = 'https://github.com/hrsh7th/cmp-path' },

    -- Treesitter
    { src = 'https://github.com/nvim-treesitter/nvim-treesitter', version = 'main' },

    -- Git
    { src = 'https://github.com/lewis6991/gitsigns.nvim' },
    { src = 'https://github.com/tpope/vim-fugitive' },

    -- Editing
    { src = 'https://github.com/m4xshen/autoclose.nvim' },

    -- Other
    { src = 'https://github.com/chomosuke/typst-preview.nvim' },
    { src = 'https://github.com/folke/snacks.nvim' },
    { src = 'https://github.com/coder/claudecode.nvim' },
})

require('user.options')
require('user.keybinds')
require('user.cmp')
require('user.nvim-tree')
require('user.nvim-treesitter')
require('user.telescope')
require('user.gitsigns')
require('user.claudecode')
require('user.which-key')

require('mason').setup()
require('bufferline').setup({})
require("autoclose").setup({})

