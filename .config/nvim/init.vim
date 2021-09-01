" external configs
source $HOME/.config/nvim/plug.vim

" regular settings
" ----------------
" ui
set number relativenumber
set ruler
set wildmenu
set showcmd

" encoding
set encoding=utf-8
set fileformats=unix,dos,mac

" searching
set nohlsearch
set incsearch
set ignorecase
set smartcase

" indent
set shiftwidth=4
set tabstop=4
set softtabstop=4
set autoindent
set expandtab

" key timeout values
" set esckeys	
set ttimeoutlen=20
set timeoutlen=1000

" allows syntax and filetype plugins
syntax enable
filetype plugin indent on

" themes
set termguicolors
"set bg=dark
"colorscheme base16-gruvbox-dark-hard
"colorscheme nord
colorscheme iceberg

" shortcuts
let mapleader = "\<Space>"
"inoremap fd <Esc>
inoremap jj <Esc>
set mouse=a
nnoremap <leader>> <C-W>>
nnoremap <leader>< <C-W><

" splitting configs
set splitbelow
set splitright

" tab stuff
nnoremap tn :tabnew<cr>
nnoremap tk :tabnext<cr>
nnoremap tj :tabprev<cr>
nnoremap th :tabfirst<cr>
nnoremap tl :tablast<cr>

nnoremap <tab> :bnext<cr>
nnoremap <S-tab> :bprev<cr>

" space-s to save
nnoremap <leader>s :w<cr>

" space-q to quit (doesn't save, watch out!)
nnoremap <leader>q :q!<cr>

" splitting
nnoremap <leader><leader>- :split
nnoremap <leader><leader>/ :vsplit

" splitting navi maps
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" copy to clipboard
map <leader>y "+y
map <leader>p "+p

vmap ++ <plug>NERDCommenterToggle
nmap ++ <plug>NERDCommenterToggle

autocmd WinLeave * setlocal statusline=%!v:lua.require'lualine'.statusline() 
autocmd WinEnter * setlocal statusline=%!v:lua.require'lualine'.statusline()
