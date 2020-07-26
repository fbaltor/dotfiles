nnoremap <leader>q :q<cr>
nnoremap <leader>w :w<cr>
nnoremap <leader>wq :wq<cr>

nnoremap <leader>bd :bd<cr>
nnoremap <leader>bw :bw<cr>

"CTRL remaps for easy window navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

nnoremap <C-Right> <C-w>>
nnoremap <C-Left> <C-w><
nnoremap <C-Up> <C-w>+
nnoremap <C-Down> <C-w>-

nnoremap <A-1> :tabr <esc>
nnoremap <A-2> :tabr <esc> :tabn <esc>


nnoremap <leader>ev :vsplit ~/.config/nvim<cr>
nnoremap <leader>sv :source ~/.config/nvim/init.vim<cr>

" Press F4 to toggle highlighting on/off, and show current value.
:noremap <F4> :set hlsearch! hlsearch?<CR>

" Mapping ZZ (save if modified and quit) to <Nop> in order to avoid mistype
" it instead of zz (center te current line in the screen)
map ZZ <Nop>
