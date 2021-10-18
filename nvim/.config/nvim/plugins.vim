let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

Plug 'gruvbox-community/gruvbox'
Plug '~/source/vimconflive2021-colorscheme'
"Plug 'vim-conf-live/vimconflive2021-colorscheme'
Plug 'ap/vim-css-color'

Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-eunuch'
Plug 'aymericbeaumet/vim-symlink'
  
Plug 'pprovost/vim-ps1'

Plug 'OrangeT/vim-csharp'

" snippets
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'


" LSP things
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-compe'
Plug 'windwp/nvim-autopairs'
Plug 'PowerShell/PowerShellEditorServices'

" Telescope and friends
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }

" fun
Plug 'ThePrimeagen/vim-be-good'
Plug 'vim-conf-live/pres.vim'

call plug#end()

"colorscheme gruvbox
colorscheme vimconflive-2021

" ultisnips config
let g:UltiSnipsEditSplit="vertical"
set completeopt=menuone,noselect,preview


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
-- extract zip from here:
-- https://github.com/PowerShell/PowerShellEditorServices/releases
-- attempts to use version built locally have not been fruitful
require('lspconfig').powershell_es.setup{
bundle_path = '~/LSP/PowershellEditorServices',
cmd = {'PowerShell.exe',
		'-NoLogo',
		'-NoProfile',
		'-Command',
		"~/LSP/PowerShellEditorServices/PowerShellEditorServices/Start-EditorServices.ps1"}
--   cmd = {'powershell.exe',
-- 		 '-NoLogo',
-- 		 '-NoProfile',
-- 		 '-Command',
-- 		 '/home/mark/.vim/plugged/PowerShellEditorServices/module/PowerShellEditorServices/Start-EditorServices.ps1'}
--   
}
-- Omnisharp
-- C# LSP
local pid = vim.fn.getpid()
local omnisharp_bin = "/home/mark/LSP/Omnisharp/run"
require'lspconfig'.omnisharp.setup{
    cmd = { omnisharp_bin, "--languageserver" , "--hostPID", tostring(pid) };
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

-- autopairs config
require('nvim-autopairs').setup()

require("nvim-autopairs.completion.compe").setup({
  map_cr = true, --  map <CR> on insert mode
  map_complete = true -- it will auto insert `(` after select function or method item
})
EOF

" Telescope config
lua << EOF
require('telescope').setup{
defaults = {
	Prompt_prefix = ">",	
	},
extensions = {
    fzf = {
      fuzzy = true,                    -- false will only do exact matching
      override_generic_sorter = false, -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
      case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                                       -- the default case_mode is "smart_case"
    }
  }
}

require('telescope').load_extension('fzf')
EOF


" Soli Deo GLoria
