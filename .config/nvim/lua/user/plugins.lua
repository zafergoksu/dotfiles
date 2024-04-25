local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = fn.system {
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
    }
    print "Installing packer close and reopen Neovim..."
    vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
    return
end

-- Have packer use a popup window
packer.init {
    display = {
        open_fn = function()
            return require("packer.util").float { border = "rounded" }
        end,
    },
}

-- Install your plugins here
return packer.startup(function(use)
    -- Useful Plugins
    use "wbthomason/packer.nvim" -- Have packer manage itself
    use "nvim-lua/popup.nvim"    -- An implementation of the Popup API from vim in Neovim
    use "nvim-lua/plenary.nvim"  -- Useful lua functions used ny lots of plugins
    use "windwp/nvim-autopairs"  -- Autopairs, integrates with both cmp and treesitter
    use "windwp/nvim-ts-autotag"
    use "numToStr/Comment.nvim"  -- Easily comment stuff
    use "JoosepAlviste/nvim-ts-context-commentstring"
    use "nvim-tree/nvim-web-devicons"
    use "nvim-tree/nvim-tree.lua"
    use { "akinsho/bufferline.nvim", requires = 'nvim-tree/nvim-web-devicons' }
    use "moll/vim-bbye"
    use "nvim-lualine/lualine.nvim"
    use "arkav/lualine-lsp-progress"
    use "nvim-lua/lsp-status.nvim"
    use "antoinemadec/FixCursorHold.nvim" -- This is needed to fix lsp doc highlight
    use "tpope/vim-surround"
    use "nvim-neotest/nvim-nio"

    -- Git
    use "lewis6991/gitsigns.nvim"
    use "tpope/vim-fugitive"

    -- Markdown Preview
    use { "iamcco/markdown-preview.nvim", ft = 'markdown', run = 'cd app && yarn install', cmd = 'MarkdownPreview' }

    -- Colorschemes
    -- moonfly
    use { "bluz71/vim-moonfly-colors", as = "moonfly" }
    -- Ayu
    use "Shatur/neovim-ayu"
    -- Gruvbox dark
    use "gruvbox-community/gruvbox"
    -- Github Themes
    use "projekt0n/github-nvim-theme"
    -- OneDarkPro
    use "navarasu/onedark.nvim"
    -- Nightfox
    use "EdenEast/nightfox.nvim"
    -- alabaster
    use "p00f/alabaster.nvim"
    -- vscode
    use "Mofiqul/vscode.nvim"
    -- tokyonight
    use "folke/tokyonight.nvim"
    -- catppuccin
    use { "catppuccin/nvim", as = "catppuccin" }
    -- rose pine
    use { "rose-pine/neovim", as = "rose-pine" }

    -- Telescope
    use "nvim-telescope/telescope.nvim"
    use "nvim-telescope/telescope-media-files.nvim"

    use "lervag/vimtex"

    -- Tresitter
    use {
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate",
    }

    -- cmp plugins
    use "hrsh7th/nvim-cmp"    -- The completion plugin
    use "hrsh7th/cmp-buffer"  -- buffer completions
    use "hrsh7th/cmp-path"    -- path completions
    use "hrsh7th/cmp-cmdline" -- cmdline completions
    use "hrsh7th/cmp-nvim-lsp"
    use "hrsh7th/cmp-nvim-lua"
    use "saadparwaiz1/cmp_luasnip" -- snippet completions
    use "David-Kunz/cmp-npm"       -- npm completion

    -- snippets
    use "L3MON4D3/LuaSnip"             --snippet engine
    use "rafamadriz/friendly-snippets" -- a bunch of snippets to use
    -- LSP
    use "neovim/nvim-lspconfig"        -- enable LSP
    use "williamboman/mason.nvim"
    use "williamboman/mason-lspconfig.nvim"
    use "jose-elias-alvarez/null-ls.nvim" -- for formatters and linters

    -- Rust
    use { "mrcjkb/rustaceanvim", version = "^4", ft = { "rust" } }

    -- Debugging
    use "mfussenegger/nvim-dap"
    use "rcarriga/nvim-dap-ui"
    use "nvim-telescope/telescope-dap.nvim"

    -- LSP Signature
    use "ray-x/lsp_signature.nvim"

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if PACKER_BOOTSTRAP then
        require("packer").sync()
    end
end)
