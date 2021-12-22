"vim-plug CONFIGURATION
call plug#begin()

Plug 'rakr/vim-one' " Simple colorscheme/theme
Plug 'neoclide/coc.nvim', {'branch': 'release'} " Intellisense
Plug 'sheerun/vim-polyglot' " Better syntax support
Plug 'gregsexton/MatchTag'
Plug 'Yggdroot/indentLine'
Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'}
Plug 'alvan/vim-closetag'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
"Plug 'Vimjas/vim-python-pep8-indent'
"Plug 'chrisbra/csv.vim'

" Initialize plugin system
call plug#end()

