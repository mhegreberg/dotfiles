let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

Plug 'gruvbox-community/gruvbox'
Plug 'pprovost/vim-ps1'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-vinegar'
Plug 'aymericbeaumet/vim-symlink'
  
" Telescope and friends
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }


call plug#end()

colorscheme gruvbox
" Telescope config
lua << EOF
require('telescope').setup{
defaults = {
	Prompt_prefix = ">",	
	}

}

require('telescope').load_extension('fzf')
EOF
