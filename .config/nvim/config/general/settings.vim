" set leader key
let mapleader = "\<space>"
let g:vim_json_syntax_conceal = 0
let g:vim_markdown_conceal = 0
let g:vim_markdown_conceal_code_blocks = 0

set mouse=a

syntax enable
set hidden
set ruler
set number
set relativenumber
set splitright
set splitbelow
set confirm
set inccommand=split
set cursorline

" stop search scan from looping from beginning
set nowrapscan
set noswapfile 

" better display for messages
set cmdheight=2

set showtabline=2 " Always display tabline

"Configurating statusline (bottomline)
set statusline=
set statusline+=%F
set statusline+=%=
set statusline+=\ %y
set statusline+=\ %p%%
set statusline+=\ %l:%c

set tabstop=8 softtabstop=0 expandtab shiftwidth=2

" display 80 characters limit 
highlight ColorColumn ctermbg=white
set colorcolumn=80

set autochdir

let g:node_client_debug = 1

" fold method for Python
"au BufNewFile, BufRead *.py \
"  set foldmethod=indent

set incsearch
set ignorecase

" Macro for go to closing HTML tag
runtime macros/matchit.vim

" set filetype
":filetype plugin on

au FileType python let b:coc_root_patterns = ['.git', '.env', 'venv', '.venv', 'setup.cfg', 'setup.py', 'pyrightconfig.json']

set backupcopy=yes
