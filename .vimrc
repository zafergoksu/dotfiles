set number
set paste
set autoindent
set pastetoggle=<F2>
syntax enable
set tabstop=4
set shiftwidth=4
set expandtab

execute pathogen#infect()
syntax on
filetype plugin indent on

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

set background=dark
colorscheme gruvbox

let g:airline_theme='gruvbox'

" air-line
let g:airline_powerline_fonts = 1

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" unicode symbols
let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.whitespace = 'Ξ'

" airline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''

let g:airline#extensions#whitespace#mixed_indent_algo=1

"let g:AutoPairs = {'(':')', '[':']', '{':'}',"'":"'",'"':'"', "`":"`", '```':'```', '"""':'"""', "'''":"'''"}

" Key mappings
	" Set Leader to Space
		let mapleader = "\<Space>"

	" I hate the Escape key
		imap <leader>q \<Esc>
		inoremap jj \<Esc>

	" tab stuff
		nnoremap tn :tabnew<cr>
		nnoremap tk :tabnext<cr>
		nnoremap tj :tabprev<cr>
		nnoremap th :tabfirst<cr>
		nnoremap tl :tablast<cr>

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

	" splitting configs
		set splitbelow
		set splitright






