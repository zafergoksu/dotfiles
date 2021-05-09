call plug#begin('~/.config/nvim/bundle')

Plug 'sheerun/vim-polyglot'
Plug 'scrooloose/nerdcommenter'
Plug 'tpope/vim-surround'

" Go support
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

Plug 'pangloss/vim-javascript'    " JavaScript support
Plug 'HerringtonDarkholme/yats.vim'
Plug 'maxmellon/vim-jsx-pretty'   " JS and JSX syntax
Plug 'jparise/vim-graphql'        " GraphQL syntax

Plug 'morhetz/gruvbox'
Plug 'chriskempson/base16-vim'

" GUI enhancements
Plug 'itchyny/lightline.vim'
Plug 'machakann/vim-highlightedyank'
Plug 'andymass/vim-matchup'
Plug 'shinchu/lightline-gruvbox.vim'

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'ryanoasis/vim-devicons'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive' " git tool

" Fuzzy finder
Plug 'junegunn/fzf.vim'

Plug 'Asheq/close-buffers.vim'

" TOML syntax highlighting.
Plug 'cespare/vim-toml' 

" rust
Plug 'rust-lang/rust.vim'

" LaTeX
Plug 'lervag/vimtex'

" call PlugInstall to install new plugins
call plug#end()
