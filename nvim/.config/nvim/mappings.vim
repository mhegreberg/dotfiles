" Use alt + hjkl to resize windows
nnoremap <M-j>    :resize -2<CR>
nnoremap <M-k>    :resize +2<CR>
nnoremap <M-h>    :vertical resize -2<CR>
nnoremap <M-l>    :vertical resize +2<CR>

" return to normal
inoremap jk <Esc>
inoremap kj <Esc>

tnoremap jk <C-\><C-n> 
tnoremap kj <C-\><C-n> 

" Better window navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

tnoremap <C-h> <C-w>h
tnoremap <C-h> <C-w>h
tnoremap <C-j> <C-w>j
tnoremap <C-k> <C-w>k

" Tab to swap buffers
nnoremap <TAB> :bnext<CR>
nnoremap <S-TAB> :bprevious<CR>

" save and run python code
nnoremap <C-p> :w <bar> :! python3 % <cr>

" append yank
nnoremap <leader>y "Ay

" easy quickfixlist nav
nnoremap <leader>[ :cprev <cr>
nnoremap <leader>] :cnext <cr>
nnoremap <leader>{ :cfirst <cr>
nnoremap <leader>} :clast <cr>


" fugitve mappings
nnoremap <leader>gg :G <cr>
nnoremap <leader>gd :Gdiff <cr>
nnoremap <leader>gl :Glog <cr>

" telescope mappings
nnoremap <leader>ff :Telescope find_files <cr> 
nnoremap <leader>fhf :Telescope find_files hidden=true <cr> 
nnoremap <leader>fg :Telescope git_files <cr> 

nnoremap <leader>fd :Telescope git_files cwd=~/dotfiles <cr> 
nnoremap <leader>fb :Telescope buffers <cr> 
nnoremap <leader>f; :Telescope commands <cr>

