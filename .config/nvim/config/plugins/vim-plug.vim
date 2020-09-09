"vim-plug CONFIGURATION
call plug#begin()

Plug 'rakr/vim-one' " Simple colorscheme/theme
Plug 'neoclide/coc.nvim', {'branch': 'release'} " Intellisense
Plug 'sheerun/vim-polyglot' " Better syntax support
Plug 'gregsexton/MatchTag'
Plug 'Yggdroot/indentLine'
Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'}
Plug 'Vimjas/vim-python-pep8-indent'

" Initialize plugin system
call plug#end()

