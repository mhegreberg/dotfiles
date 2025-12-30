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

" Treesitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate', 'branch': 'master'}
Plug 'nvim-treesitter/playground'

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
"Plug 'hrsh7th/nvim-compe'
Plug 'windwp/nvim-autopairs'
Plug 'PowerShell/PowerShellEditorServices'
Plug 'https://git.sr.ht/~whynothugo/lsp_lines.nvim'
Plug 'towolf/vim-helm'

" cmp things
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/cmp-calc'
Plug 'hrsh7th/cmp-nvim-lsp-document-symbol'
Plug 'PhilRunninger/cmp-rpncalc'
Plug 'hrsh7th/nvim-cmp'
Plug 'quangnguyen30192/cmp-nvim-ultisnips'
Plug 'onsails/lspkind.nvim'

" Debugging
Plug 'mfussenegger/nvim-dap'
Plug 'rcarriga/nvim-dap-ui'
Plug 'nvim-neotest/nvim-nio'
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
Plug 'Eandrju/cellular-automaton.nvim'

" llm
" Plug 'github/copilot.vim' " this was not fun to use


call plug#end()


colorscheme gruvbox
hi! Normal ctermbg=NONE guibg=NONE
"colorscheme vimconflive-2021

" ultisnips config
let g:UltiSnipsEditSplit="vertical"
set completeopt=menuone,noselect,preview

" vimwiki config
let g:vimwiki_list = [{'path':  '~/vimwiki', 'auto_diary_index': 1}]

" LSP config
lua << EOF
 -- Set up nvim-cmp.
 local cmp = require'cmp'
 local lspkind = require'lspkind'

 cmp.setup({
   snippet = {
     -- REQUIRED - you must specify a snippet engine
     expand = function(args)
       --vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
       -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
       -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
        vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
       -- vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)
     end,
   },
   window = {
     -- completion = cmp.config.window.bordered(),
     -- documentation = cmp.config.window.bordered(),
   },
   mapping = cmp.mapping.preset.insert({
     ['<C-b>'] = cmp.mapping.scroll_docs(-4),
     ['<C-f>'] = cmp.mapping.scroll_docs(4),
     ['<C-Space>'] = cmp.mapping.complete(),
     ['<C-e>'] = cmp.mapping.abort(),
     ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
     

   }),
   sources = cmp.config.sources({
     { name = 'nvim_lsp' },
     -- { name = 'vsnip' }, -- For vsnip users.
     -- { name = 'luasnip' }, -- For luasnip users.
     { name = 'ultisnips' }, -- For ultisnips users.
     -- { name = 'snippy' }, -- For snippy users.
   }, {
     { name = 'buffer' },
   })
 })

 -- To use git you need to install the plugin petertriho/cmp-git and uncomment lines below
 -- Set configuration for specific filetype.
 --[[ cmp.setup.filetype('gitcommit', {
   sources = cmp.config.sources({
     { name = 'git' },
   }, {
     { name = 'buffer' },
   })
})
require("cmp_git").setup() ]]-- 

 -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
 cmp.setup.cmdline({ '/', '?' }, {
   mapping = cmp.mapping.preset.cmdline(),
   sources = {
     { name = 'buffer' }
   }
 })

 -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
 cmp.setup.cmdline(':', {
   mapping = cmp.mapping.preset.cmdline(),
   sources = cmp.config.sources({
     { name = 'nvim_lsp_document_symbol' },
     { name = 'path' }
   }, {
     { name = 'cmdline' }
   }),
   matching = { disallow_symbol_nonprefix_matching = false }
 })

 -- Set up lspconfig.
 local capabilities = require('cmp_nvim_lsp').default_capabilities()
 -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.



require("lsp_lines").setup()
require("lsp_lines").toggle()
vim.diagnostic.config({
	virtual_text = { spacing = 4, prefix = "●" }
})

local function toggle_diagnostics()
  local diagnostics_on = require("lsp_lines").toggle()
  if diagnostics_on then
    vim.diagnostic.config({
      virtual_text = false,
    })
  else
    vim.diagnostic.config({
      virtual_text = { spacing = 4, prefix = "●" },
    })
  end
end
vim.keymap.set("n", "<Leader>ch", toggle_diagnostics, { desc = "Toggle [i]nline diagnostic type" })

-- jinja
--cargo install jinja-lsp
vim.filetype.add {
  extension = {
    jinja = 'jinja',
    jinja2 = 'jinja',
    j2 = 'jinja',
  },
}
vim.lsp.enable('jinja_lsp')
vim.lsp.config('eslint',
{
	capabilities = capabilites
}
)
vim.lsp.enable('eslint')

vim.lsp.config('rust_analyzer',{
	capabilities = capabilites
})
vim.lsp.enable('rust_analyzer')
-- installed with:
-- npm i -g pyright
vim.lsp.config('pyright',
{
	capabilities = capabilites
})
vim.lsp.enable('pyright')


-- installed with:
-- npm i -g typescript typescript-language-server
vim.lsp.config('ts_ls',
{
	capabilities = capabilites
})
vim.lsp.enable('ts_ls')

-- installed with:
-- npm install -g vim-language-server
--vim.lsp.config('vimls',
--{	
--capabilities = capabilites
--})
--vim.lsp.enable('vimls')

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

vim.lsp.config('omnisharp',{
	capabilities = capabilites,
    cmd = { omnisharp_bin, "--languageserver" , "--hostPID", tostring(pid) },
	filetypes = {"cs", "vb", "razor", "cshtml"},
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

	
	on_attach = attach,

})
vim.lsp.enable('omnisharp')

--require'lspconfig'.csharp_ls.setup{}
vim.lsp.config('hls',{
	capabilities = capabilites
})
vim.lsp.enable('hls')

-- ruby
vim.lsp.config('ruby_lsp',
{
	capabilities = capabilites
})
vim.lsp.enable('ruby_lsp')

vim.lsp.config('helm_ls',
{
	capabilities = capabilites
})
vim.lsp.enable('helm_ls')
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

" cmp config
lua <<EOF
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
  ignore_install = { "phpdoc", "ipkg" }, -- List of parsers to ignore installing
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
  playground = {
    enable = true,
    disable = {},
    updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
    persist_queries = false, -- Whether the query persists across vim sessions
    keybindings = {
      toggle_query_editor = 'o',
      toggle_hl_groups = 'i',
      toggle_injected_languages = 't',
      toggle_anonymous_nodes = 'a',
      toggle_language_display = 'I',
      focus_language = 'f',
      unfocus_language = 'F',
      update = 'R',
      goto_node = '<cr>',
      show_help = '?',
    },
  },
  query_linter = {
      enable = true,
      use_virtual_text = true,
      lint_events = {"BufWrite", "CursorHold"},
    },
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
