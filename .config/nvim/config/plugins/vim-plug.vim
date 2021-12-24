"vim-plug CONFIGURATION
call plug#begin()

Plug 'rakr/vim-one' " Simple colorscheme/theme
Plug 'neoclide/coc.nvim', {'branch': 'master', 'do': 'yarn install --frozen-lockfile'}
Plug 'sheerun/vim-polyglot' " Better syntax support
Plug 'gregsexton/MatchTag'
Plug 'Yggdroot/indentLine'
Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'}
Plug 'alvan/vim-closetag'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'} " We recommend updating the parsers on update
"Plug 'Vimjas/vim-python-pep8-indent'
"Plug 'chrisbra/csv.vim'

" Initialize plugin system
call plug#end()

