call plug#begin('~/.config/nvim/bundle')
"Plug 'vim-airline/vim-airline'
"Plug 'vim-airline/vim-airline-themes'
Plug 'scrooloose/nerdcommenter'
Plug 'pangloss/vim-javascript'

" Go support
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

" JSX and TSX support
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
Plug 'ianks/vim-tsx'

Plug 'morhetz/gruvbox'
Plug 'arcticicestudio/nord-vim'
Plug 'joshdick/onedark.vim'
Plug 'chriskempson/base16-vim'

" GUI enhancements
Plug 'itchyny/lightline.vim'
"Plug 'mengelbrecht/lightline-bufferline'
Plug 'machakann/vim-highlightedyank'
Plug 'andymass/vim-matchup'
Plug 'shinchu/lightline-gruvbox.vim'

Plug 'neoclide/coc.nvim', {'branch': 'release'}
" use pip install jedi to have proper python support with coc
" Plug 'davidhalter/jedi-vim'
" Plug 'tsony-tsonev/nerdtree-git-plugin'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'ryanoasis/vim-devicons'
Plug 'airblade/vim-gitgutter'
"Plug 'ctrlpvim/ctrlp.vim' " fuzzy find files
Plug 'tpope/vim-fugitive' " git tool

" Fuzzy finder
"Plug 'airblade/vim-rooter'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

Plug 'jiangmiao/auto-pairs'
Plug 'Asheq/close-buffers.vim'

" TOML syntax highlighting.
Plug 'cespare/vim-toml' 

" rust
Plug 'rust-lang/rust.vim'

" call PlugInstall to install new plugins
call plug#end()

" basics
set encoding=UTF-8
set number relativenumber
set incsearch
set ignorecase
set smartcase
set nohlsearch
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set nobackup
set noswapfile
set notimeout

" Syntax enable
"let $NVIM_TUI_ENABLE_TRUE_COLOR=1
syntax on
set termguicolors
set bg=dark
let base16colorspace=256
"colorscheme gruvbox
colorscheme base16-gruvbox-dark-hard
"colorscheme nord

" colorscheme onedark

" Brighter comments
"call Base16hi("Comment", g:base16_gui09, "", g:base16_cterm09, "", "", "")

" preferences
" inoremap fd <ESC>
let mapleader = "\<Space>"
imap fd <Esc>
set pastetoggle=<F2>
set mouse=a
set autoindent
set smartindent

filetype on
filetype plugin on
filetype indent on

"nmap <C-n> :NERDTreeToggle<CR>
vmap ++ <plug>NERDCommenterToggle
nmap ++ <plug>NERDCommenterToggle

" set filetypes as typescript.tsx
autocmd BufNewFile,BufRead *.tsx,*.jsx set filetype=typescript.tsx

"let g:NERDTreeGitStatusWithFlags = 1
"" let g:WebDevIconsUnicodeDecorateFolderNodes = 1
"" let g:NERDTreeGitStatusNodeColorization = 1
"let g:NERDTreeColorMapCustom = {
    "\ "Staged"    : "#0ee375",  
    "\ "Modified"  : "#d9bf91",  
    "\ "Renamed"   : "#51C9FC",  
    "\ "Untracked" : "#FCE77C",  
    "\ "Unmerged"  : "#FC51E6",  
    "\ "Dirty"     : "#FFBD61",  
    "\ "Clean"     : "#87939A",   
    "\ "Ignored"   : "#808080",
    "\ }

"let g:NERDTreeIgnore = ['^node_modules$']

" vim-prettier
command! -nargs=0 Prettier :CocCommand prettier.formatFile

" <leader>s for Rg search
noremap <C-t> :Rg
let g:fzf_layout = { 'down': '~20%' }
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

noremap <C-f> :Files <cr>

function! s:list_cmd()
  let base = fnamemodify(expand('%'), ':h:.:S')
  return base == '.' ? 'fd --type file --follow' : printf('fd --type file --follow | proximity-sort %s', shellescape(expand('%')))
endfunction

"command! -bang -nargs=? -complete=dir Files
  "\ call fzf#vim#files(<q-args>, {'source': s:list_cmd(),
  "\                               'options': '--tiebreak=index'}, <bang>0)

let $FZF_DEFAULT_COMMAND = 'ag -l -g ""'
let $FZF_DEFAULT_OPTS="--preview '[[ $(file --mime {}) =~ binary ]] && echo {} is a binary file || (bat --style=numbers --color=always {} || highlight -O ansi -l {} || coderay {} || rougify {} || cat {}) 2> /dev/null'"
let g:fzf_layout = { 'down': '40%' }
let g:fzf_nvim_statusline = 0

set hidden
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

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

" GoTo code navigation.
nmap <leader>gd <Plug>(coc-definition)
nmap <leader>gy <Plug>(coc-type-definition)
nmap <leader>gi <Plug>(coc-implementation)
nmap <leader>gr <Plug>(coc-references)
nmap <leader>rr <Plug>(coc-rename)
" Use `[g` and `]g` to navigate diagnostics
nmap <leader>g[ <Plug>(coc-diagnostic-prev)
nmap <leader>g] <Plug>(coc-diagnostic-next)
nmap <silent> <leader>gp <Plug>(coc-diagnostic-prev-error)
nmap <silent> <leader>gn <Plug>(coc-diagnostic-next-error)
nnoremap <leader>cr :CocRestart

nnoremap <C-p> :GFiles<CR>
nnoremap <leader><leader>b :Buffers<CR>

" Explorer
nmap <leader>e :CocCommand explorer<CR>
"autocmd BufEnter * if (winnr("$") == 1 && &filetype == 'coc-explorer') | q | endif

nnoremap <leader>> <C-W>>
nnoremap <leader>< <C-W><

" splitting configs
set splitbelow
set splitright

inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Or use `complete_info` if your vim support it, like:
" inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <F2> <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

" air-line
"let g:airline_powerline_fonts = 1
"let g:airline#extensions#whitespace#mixed_indent_algo = 1

"if !exists('g:airline_symbols')
    "let g:airline_symbols = {}
"endif

 "unicode symbols
"let g:airline_left_sep = '»'
"let g:airline_left_sep = '▶'
"let g:airline_right_sep = '«'
"let g:airline_right_sep = '◀'
"let g:airline_symbols.linenr = '␊'
"let g:airline_symbols.linenr = '␤'
"let g:airline_symbols.linenr = '¶'
"let g:airline_symbols.branch = '⎇'
"let g:airline_symbols.paste = 'ρ'
"let g:airline_symbols.paste = 'Þ'
"let g:airline_symbols.paste = '∥'
"let g:airline_symbols.whitespace = 'Ξ'

 "airline symbols
"let g:airline_left_sep = ''
"let g:airline_left_alt_sep = ''
"let g:airline_right_sep = ''
"let g:airline_right_alt_sep = ''
"let g:airline_symbols.branch = ''
"let g:airline_symbols.readonly = ''
"let g:airline_symbols.linenr = ''

" Lightline
let g:lightline = {
      \ 'colorscheme': 'gruvbox',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'cocstatus', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_expand': {
      \   'buffers': 'lightline#bufferline#buffers'
      \ },
      \ 'component_type': {
      \   'buffers': 'tabsel'
      \ },
      \ 'component_function': {
      \   'filename': 'LightlineFilename',
      \   'cocstatus': 'coc#status'
      \ }
      \ }
function! LightlineFilename()
  return expand('%:t') !=# '' ? @% : '[No Name]'
endfunction

"" Use auocmd to force lightline update.
"autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()

" Use auocmd to force lightline update.
"autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()


" coc config
let g:coc_global_extensions = [
  \ 'coc-snippets',
  \ 'coc-html',
  \ 'coc-css',
  \ 'coc-tsserver',
  \ 'coc-eslint', 
  \ 'coc-prettier', 
  \ 'coc-json', 
  \ 'coc-python',
  \ 'coc-java',
  \ 'coc-explorer',
  \ ]
" from readme
