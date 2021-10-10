call plug#begin('~/.config/nvim/bundle')

Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-surround'
Plug 'cohama/lexima.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'machakann/vim-highlightedyank'

"Plug 'morhetz/gruvbox'
"Plug 'arcticicestudio/nord-vim'
Plug 'cocopon/iceberg.vim'

Plug 'prettier/vim-prettier', {
  \ 'do': 'yarn install',
  \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'svelte', 'yaml', 'html'] }

Plug 'Asheq/close-buffers.vim'

" TOML syntax highlighting.
Plug 'cespare/vim-toml' 

" rust
Plug 'rust-lang/rust.vim'

" LaTeX
Plug 'lervag/vimtex'

if has("nvim")
    Plug 'kristijanhusak/defx-git'
    Plug 'kristijanhusak/defx-icons'
    Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins' }
    
    Plug 'neovim/nvim-lspconfig'
    Plug 'kabouzeid/nvim-lspinstall'
    Plug 'glepnir/lspsaga.nvim'
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
    Plug 'nvim-treesitter/nvim-treesitter-textobjects'
    Plug 'nvim-lua/lsp_extensions.nvim'
    "Plug 'nvim-lua/completion-nvim'
    Plug 'hrsh7th/cmp-nvim-lsp'
    Plug 'hrsh7th/cmp-buffer'
    Plug 'hrsh7th/nvim-cmp'
    Plug 'folke/lsp-colors.nvim'
    
    Plug 'nvim-lua/popup.nvim'
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope.nvim'
    Plug 'nvim-lua/lsp-status.nvim' 
    Plug 'kyazdani42/nvim-web-devicons'
    Plug 'hoob3rt/lualine.nvim'
endif

" call PlugInstall to install new plugins
call plug#end()
