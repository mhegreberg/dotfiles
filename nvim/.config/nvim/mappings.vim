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

" lsp mappings
nnoremap gd <cmd>lua vim.lsp.buf.definition()<cr>
nnoremap gD <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap gr <cmd>lua vim.lsp.buf.references()<CR>
nnoremap gi <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap K <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <C-n> <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>
nnoremap <C-p> <cmd>lua vim.lsp.diagnostic.goto_next()<CR>
nnoremap <C-f> <cmd>lua vim.lsp.buf.formatting_sync(nil, 100)<CR>
nnoremap <leader>ca <cmd>lua vim.lsp.buf.code_action()<CR>

" compe mappings 

" inoremap <silent><expr> <C-Space> compe#complete()
" inoremap <silent><expr> <CR>      compe#confirm('<CR>')
" inoremap <silent><expr> <C-e>     compe#close('<C-e>')
" inoremap <silent><expr> <C-f>     compe#scroll({ 'delta': +4 })
" inoremap <silent><expr> <C-d>     compe#scroll({ 'delta': -4 })
 
" UltiSnips mappings
nnoremap <leader>sl :UltiSnipsEdit <CR>


" interesting ideas
vnoremap <leader>p "_dP
nnoremap <leader>d "_d
vnoremap <leader>d "_d
