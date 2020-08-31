nnoremap <leader>q :q<cr>
nnoremap <leader>ww :w<cr>
nnoremap <leader>wq :wq<cr>

"CTRL remaps for easy window navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

"CTRL remaps for easy window resizing
nnoremap <C-Right> <C-w>>
nnoremap <C-Left> <C-w><
nnoremap <C-Up> <C-w>+
nnoremap <C-Down> <C-w>-

"ALT remaps for moving screen view
nnoremap <Up> <C-y>k<esc>
nnoremap <Down> <C-e>j<esc>

"[WARNING] Moving between tabs
nnoremap <A-1> :tabr <esc>
nnoremap <A-2> :tabr <esc> :tabn <esc>

nnoremap <leader>ev :vsplit ~/.config/nvim<cr>
nnoremap <leader>sv :source ~/.config/nvim/init.vim<cr>

" Press F4 to toggle highlighting on/off, and show current value.
noremap <F4> :set hlsearch! hlsearch?<cr>

" Mapping ZZ (save if modified and quit) to <Nop> in order to avoid mistype
" it instead of zz (center te current line in the screen)
map ZZ <Nop>

nnoremap <BS> :Rexplore<cr>

nnoremap <C-c> :%y+<cr>
