call plug#begin('~/.config/nvim/bundle')

Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-surround'
Plug 'cohama/lexima.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'machakann/vim-highlightedyank'

Plug 'morhetz/gruvbox'
Plug 'arcticicestudio/nord-vim'

if has("nvim")
    Plug 'kristijanhusak/defx-git'
    Plug 'kristijanhusak/defx-icons'
    Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins' }

    Plug 'neovim/nvim-lspconfig'
    Plug 'kabouzeid/nvim-lspinstall'
    Plug 'glepnir/lspsaga.nvim'
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
    Plug 'nvim-treesitter/nvim-treesitter-textobjects'
    Plug 'nvim-lua/completion-nvim'
    Plug 'folke/lsp-colors.nvim'
    
    Plug 'nvim-lua/popup.nvim'
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope.nvim'
    
    Plug 'kyazdani42/nvim-web-devicons'
	" Plug 'hoob3rt/lualine.nvim'
endif

" call PlugInstall to install new plugins
call plug#end()

vmap ++ <plug>NERDCommenterToggle
nmap ++ <plug>NERDCommenterToggle
