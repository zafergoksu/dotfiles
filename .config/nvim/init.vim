" external configs
source $HOME/.config/nvim/plugins.vim

" regular settings
" ----------------
" ui
set number relativenumber
set ruler
set wildmenu
set showcmd
set showmatch

" encoding
set encoding=utf-8
set fileformats=unix,dos,mac

" searching
set hlsearch
set incsearch
set ignorecase
set smartcase

" indent
set shiftwidth=4
set tabstop=4
set softtabstop=4
set autoindent

" key timeout values
" set esckeys	
set ttimeoutlen=20
set timeoutlen=1000

" allows syntax and filetype plugins
syntax enable
filetype plugin indent on

" themes
set termguicolors
set bg=dark
colorscheme base16-gruvbox-dark-hard

" shortcuts
let mapleader = "\<Space>"
imap fd <Esc>
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
map <Leader>y "+y
map <Leader>p "+p

source $HOME/.config/nvim/plugin-shortcuts.vim

" autocmds
"---------
augroup general
    autocmd!
    "keep equal proportions when windows resized
    autocmd VimResized * wincmd =
    "save cursor position in a file
    autocmd BufReadPost * if line("'\"") > 1 && line("'\"")
                \ <= line("$") | exe "normal! g'\"" | endif
augroup END
