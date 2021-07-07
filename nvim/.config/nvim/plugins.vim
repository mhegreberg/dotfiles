let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

Plug 'gruvbox-community/gruvbox'

" LSP things
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-compe'
Plug 'PowerShell/PowerShellEditorServices'

Plug 'pprovost/vim-ps1'

Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-vinegar'
Plug 'aymericbeaumet/vim-symlink'
  
" Telescope and friends
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }

Plug 'sbdchd/neoformat'

Plug 'ThePrimeagen/vim-be-good'
call plug#end()

colorscheme gruvbox


" LSP config
lua << EOF

-- installed with:
-- npm i -g pyright
require('lspconfig').pyright.setup{}

-- installed with:
-- npm i -g typescript typescript-language-server
require('lspconfig').tsserver.setup{}

-- installed with:
-- npm install -g vim-language-server
require'lspconfig'.vimls.setup{}
-- installed with black magic. Here be dragons
require('lspconfig').powershell_es.setup{
  cmd = {'powershell.exe',
		 '-NoLogo',
		 '-NoProfile',
		 '-Command',
		 '\\\\wsl$\\Debian\\home\\mark\\.vim\\plugged\\PowerShellEditorServices\\module\\PowerShellEditorServices\\Start-EditorServices.ps1'}
  
}
EOF

" compe config
lua << EOF

require'compe'.setup {
  enabled = true;
  autocomplete = true;
  debug = false;
  min_length = 1;
  preselect = 'enable';
  throttle_time = 80;
  source_timeout = 200;
  resolve_timeout = 800;
  incomplete_delay = 400;
  max_abbr_width = 100;
  max_kind_width = 100;
  max_menu_width = 100;
  documentation = {
    border = { '', '' ,'', ' ', '', '', '', ' ' }, -- the border option is the same as `|help nvim_open_win|`
    winhighlight = "NormalFloat:CompeDocumentation,FloatBorder:CompeDocumentationBorder",
    max_width = 120,
    min_width = 60,
    max_height = math.floor(vim.o.lines * 0.3),
    min_height = 1,
  };

  source = {
    path = true;
    buffer = true;
    calc = true;
    nvim_lsp = true;
    nvim_lua = true;
    vsnip = true;
    ultisnips = true;
    luasnip = true;
  };
}
EOF

" Telescope config
lua << EOF
require('telescope').setup{
defaults = {
	Prompt_prefix = ">",	
	}

}

require('telescope').load_extension('fzf')
EOF
