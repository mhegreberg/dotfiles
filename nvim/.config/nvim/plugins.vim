let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

" colors
Plug 'gruvbox-community/gruvbox'
Plug 'vim-conf-live/vimconflive2021-colorscheme'
Plug 'ap/vim-css-color'

" syntax-highlighing extention
"Plug 'pprovost/vim-ps1'
"Plug 'OrangeT/vim-csharp'
"Plug 'neovimhaskell/haskell-vim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" tpope
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-eunuch'
Plug 'aymericbeaumet/vim-symlink'
  

Plug 'vimwiki/vimwiki'


" snippets
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'


" LSP things
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-compe'
Plug 'windwp/nvim-autopairs'
Plug 'PowerShell/PowerShellEditorServices'

" Debugging
Plug 'mfussenegger/nvim-dap'
Plug 'rcarriga/nvim-dap-ui'
Plug 'theHamsta/nvim-dap-virtual-text'
Plug 'nvim-telescope/telescope-dap.nvim'

" project navigation
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'kyazdani42/nvim-web-devicons'
Plug 'ThePrimeagen/harpoon'
" fun
Plug 'ThePrimeagen/vim-be-good'
Plug 'vim-conf-live/pres.vim'

call plug#end()

colorscheme gruvbox
"colorscheme vimconflive-2021

" ultisnips config
let g:UltiSnipsEditSplit="vertical"
set completeopt=menuone,noselect,preview

" vimwiki config
let g:vimwiki_list = [{'path':  '~/vimwiki', 'auto_diary_index': 1}]

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
--require('lspconfig').powershell_es.setup{
--bundle_path = '~/LSP/PowershellEditorServices',
--cmd = {'PowerShell.exe',
--		'-NoLogo',
--		'-NoProfile',
--		'-Command',
--		"~/LSP/PowerShellEditorServices/PowerShellEditorServices/Start-EditorServices.ps1"}
----   cmd = {'powershell.exe',
---- 		 '-NoLogo',
---- 		 '-NoProfile',
---- 		 '-Command',
---- 		 '/home/mark/.vim/plugged/PowerShellEditorServices/module/PowerShellEditorServices/Start-EditorServices.ps1'}
----   
--}
-- Omnisharp
-- C# LSP
local pid = vim.fn.getpid()
local omnisharp_bin = "omnisharp"
require'lspconfig'.omnisharp.setup{
    cmd = { omnisharp_bin, "--languageserver" , "--hostPID", tostring(pid) };
    -- Enables support for reading code style, naming convention and analyzer
    -- settings from .editorconfig.
    enable_editorconfig_support = true,

    -- If true, MSBuild project system will only load projects for files that
    -- were opened in the editor. This setting is useful for big C# codebases
    -- and allows for faster initialization of code navigation features only
    -- for projects that are relevant to code that is being edited. With this
    -- setting enabled OmniSharp may load fewer projects and may thus display
    -- incomplete reference lists for symbols.
    enable_ms_build_load_projects_on_demand = false,

    -- Enables support for roslyn analyzers, code fixes and rulesets.
    enable_roslyn_analyzers = false,

    -- Specifies whether 'using' directives should be grouped and sorted during
    -- document formatting.
    organize_imports_on_format = true,

    -- Enables support for showing unimported types and unimported extension
    -- methods in completion lists. When committed, the appropriate using
    -- directive will be added at the top of the current file. This option can
    -- have a negative impact on initial completion responsiveness,
    -- particularly for the first few completion sessions after opening a
    -- solution.
    enable_import_completion = true,

    -- Specifies whether to include preview versions of the .NET SDK when
    -- determining which version to use for project loading.
    sdk_include_prereleases = true,

    -- Only run analyzers against open files when 'enableRoslynAnalyzers' is
    -- true
    analyze_open_documents_only = false,
}

--require'lspconfig'.csharp_ls.setup{}
require'lspconfig'.hls.setup{
}

EOF

" nvim-dap
lua << EOF

require("nvim-dap-virtual-text").setup()
require("dapui").setup()

local dap, dapui = require("dap"), require("dapui")
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.after.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.after.event_exited["dapui_config"] = function()
  dapui.close()
end
    dap.adapters.coreclr = {
      type = 'executable',
      command = 'netcoredbg',
      args = {'--interpreter=vscode'}
    }

	dap.configurations.cs = {
	  {
		type = "coreclr",
		name = "launch - netcoredbg",
		request = "launch",
		program = function()
			return vim.fn.input('Path to dll', vim.fn.getcwd() .. '/bin/Debug/', 'file')
		end,
	  },
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
	initial_mode = "insert",
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

" Harpoon config
lua << EOF
require("harpoon").setup({
    global_settings = {
        save_on_toggle = false,
        save_on_change = true,
        enter_on_sendcmd = false,
    }
})

EOF

" Treesitter config
lua << EOF
require'nvim-treesitter.configs'.setup {
ensure_installed = "all", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  ignore_install = { "phpdoc" }, -- List of parsers to ignore installing
  highlight = {
    enable = true,              -- false will disable the whole extension
    disable = {},  -- list of language that will be disabled
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = true,
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    },
  },
  indent = {
    enable = true
  },
}

local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
parser_config.haskell = {
  install_info = {
    url = "~/source/tree-sitter-haskell",
    files = {"src/parser.c", "src/scanner.cc"}
  }
}

EOF

" devicons"
lua << EOF
require'nvim-web-devicons'.setup {
 -- your personnal icons can go here (to override)
 -- you can specify color or cterm_color instead of specifying both of them
 -- DevIcon will be appended to `name`
 override = {
  csproj = {
    icon = "",
    color = "#854CC7",
    cterm_color = "98",
    name = "CSProj",
  },
  cshtml = {
    icon = "",
    color = "#e44d26",
    cterm_color = "202",
    name = "Razor",
  }
 };
 -- globally enable default icons (default to false)
 -- will get overriden by `get_icons` option
}

EOF


" Soli Deo Gloria
