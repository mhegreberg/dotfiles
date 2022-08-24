" Use alt + hjkl to resize windows
nnoremap <C-A-j>    :resize -2<CR>
nnoremap <C-A-k>    :resize +2<CR>
nnoremap <C-A-h>    :vertical resize -2<CR>
nnoremap <C-A-l>    :vertical resize +2<CR>

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

" move text
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv

" append yank
nnoremap <leader>y "Ay

" yank to end
nnoremap Y y$

" easy quickfixlist nav
nnoremap <leader>[ :cprev <cr>
nnoremap <leader>] :cnext <cr>
nnoremap <leader>{ :cfirst <cr>
nnoremap <leader>} :clast <cr>
nnoremap <leader><leader>[ :copen <cr>
nnoremap <leader><leader>] :cclose <cr>

" diffthis
nnoremap <leader>dt :windo diffthis <cr>
nnoremap <leader>do :diffoff <cr>

" save as root
cmap w!! w !sudo tee % <cr>

" clear highlighting
nnoremap <leader>/ :nohl <cr>

" fugitve mappings
nnoremap <leader>gg :G <cr>
nnoremap <leader>gd :Gdiff <cr>
nnoremap <leader>gl :Gclog <cr>
nnoremap <leader>gb :G blame <cr>
nnoremap <leader>gmh :diffget //2 \| diffupdate <cr>
nnoremap <leader>gml :diffget //3 \| diffupdate <cr>

" telescope mappings
nnoremap <leader>ff :Telescope find_files initial_mode=insert<cr> 
nnoremap <leader>fhf :Telescope find_files hidden=true <cr> 
nnoremap <leader>fg :Telescope git_files <cr>

nnoremap <leader>fd :Telescope git_files cwd=~/dotfiles <cr> 
nnoremap <leader>fw :Telescope live_grep cwd=~/vimwiki <cr> 
nnoremap <leader>fb :Telescope buffers <cr> 
nnoremap <leader>f; :Telescope commands <cr>
nnoremap <leader>ft :Telescope live_grep <cr>

" Harpoon mappings
nnoremap <leader>ha :lua require("harpoon.mark").add_file() <cr>
nnoremap <leader><leader>h :lua require("harpoon.ui").toggle_quick_menu() <CR>
nnoremap <C-A-j> :lua require("harpoon.ui").toggle_quick_menu() <CR>

nnoremap <leader>hh :lua require("harpoon.ui").nav_file(1) <cr>
nnoremap <leader>hj :lua require("harpoon.ui").nav_file(2) <cr>
nnoremap <leader>hk :lua require("harpoon.ui").nav_file(3) <cr>
nnoremap <leader>hl :lua require("harpoon.ui").nav_file(4) <cr>


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
