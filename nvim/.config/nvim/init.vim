source $HOME/.config/nvim/vim-plug/plugins.vim

set hidden
set incsearch
set signcolumn=yes
set clipboard=unnamedplus
set lazyredraw
set ttyfast
set splitbelow
set splitright
set number relativenumber
set updatetime=300


" -------------------------------------------------------------------------------------------------
" Folding
" -------------------------------------------------------------------------------------------------
set foldlevel=20
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()

" -------------------------------------------------------------------------------------------------
" Theme
" -------------------------------------------------------------------------------------------------

colorscheme tokyonight-night

" Bufferline
set termguicolors
lua << EOF
require("bufferline").setup{}
EOF

" Lualine
lua << END
require('lualine').setup({  sections = {
  lualine_a = {'mode'},
  lualine_b = {'filename'},
  lualine_c = {'diagnostics', 'diff'},
  lualine_x = {'searchcount', 'diff'},
  lualine_y = {'progress'},
  lualine_z = {'location'}
}})
END

" Scrollbar
lua << END
require("scrollbar").setup()
END

" DASHBOARD
let g:dashboard_default_executive ='telescope'

" -------------------------------------------------------------------------------------------------
" FML
" -------------------------------------------------------------------------------------------------

" -------------------------------------------------------------------------------------------------
" Improvements 
" -------------------------------------------------------------------------------------------------

augroup highlight_yank
  autocmd!
  au TextYankPost * silent! lua vim.highlight.on_yank { higroup='IncSearch', timeout=200 }
augroup END


" Navigate between tabs
nmap <Tab> :bn<cr>
nmap <S-Tab> :bp<cr>

" Move lines up and down
nnoremap <A-Down> :m .+1<CR>==
nnoremap <A-Up> :m .-2<CR>==
inoremap <A-Down> <Esc>:m .+1<CR>==gi
inoremap <A-Up> <Esc>:m .-2<CR>==gi
vnoremap <A-Down> :m '>+1<CR>gv=gv
vnoremap <A-Up> :m '<-2<CR>gv=gv

" Split Vertically
nnoremap <silent> vv <C-w>v

" autoformat on save
augroup fmt
  autocmd!
  autocmd BufWritePre * undojoin | Neoformat
augroup END

" AUTO CLOSE
" filenames like *.xml, *.html, *.xhtml, ...
" These are the file extensions where this plugin is enabled.
let g:closetag_filenames = '*.html,*.js,*.ts,*.xhtml,*.phtml'

" Git highlight
lua <<EOF
require('gitsigns').setup()
EOF

" -------------------------------------------------------------------------------------------------
" Telescope 
" -------------------------------------------------------------------------------------------------

let mapleader = " "
nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files({})<cr>
nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>
nnoremap <leader>fc <cmd>lua require('telescope.builtin').commands()<cr>
nnoremap <leader>fd <cmd>lua require('telescope.builtin').lsp_document_symbols()<cr>

lua << EOF
require("telescope").setup {
  defaults = {
    file_ignore_patterns = {
    "node_modules", "build", "dist", ".git", "yarn.lock",".next"
    }
    },
  pickers = {
    find_files = {
      hidden = true
    },
    buffers = {
      show_all_buffers = true,
      sort_lastused = true,
      theme = "dropdown",
      previewer = false,
      mappings = {
        n = {
          ["<x>"] = "delete_buffer",
        }
        }
      },
    lsp_document_symbols = {
      sort_lastused = true,
      theme = "dropdown",
      previewer = false,
    }
    }
  }
EOF

" -------------------------------------------------------------------------------------------------
" Copilot 
" -------------------------------------------------------------------------------------------------
" lua << EOF
" vim.g.copilot_assume_mapped = true
" EOF

" -------------------------------------------------------------------------------------------------
" TreeSitter 
" -------------------------------------------------------------------------------------------------
lua <<EOF
require'nvim-treesitter.configs'.setup {
  textobjects = {
    select = {
      enable = true,

      -- Automatically jump forward to textobj, similar to targets.vim
      lookahead = true,

      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
        ["il"] = "@loop.inner",
        ["al"] = "@loop.outer",
        ["ii"] = "@conditional.inner",
        ["ai"] = "@conditional.outer",
        },
      },
    },
}
EOF


" nvim-treesitter {{{
lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = { 'html', 'javascript', 'typescript', 'tsx', 'css', 'json' },
  -- ensure_installed = "all", -- or maintained
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = true
  },
  indent = {
    enable = false
  },
  context_commentstring = {
    enable = true
  }
  }
EOF
" }}}

" peitalin/vim-jsx-typescript {{{
autocmd BufNewFile,BufRead *.tsx,*.jsx set filetype=typescriptreact
" }}}

" -------------------------------------------------------------------------------------------------
" LSP 
" -------------------------------------------------------------------------------------------------

" neovim/nvim-lspconfig {{{
" npm i -g typescript typescript-language-server
lua << EOF
local util = require "lspconfig/util"
require 'lspconfig'.tsserver.setup{
on_attach = function(client)
client.server_capabilities.documentFormattingProvider = true
end,
root_dir = util.root_pattern(".git", "tsconfig.json", "jsconfig.json"),
--[=====[ 
handlers = {
["textDocument/publishDiagnostics"] = function(_, _, params, client_id, _, config)
local ignore_codes = { 80001, 7016 };
if params.diagnostics ~= nil then
  local idx = 1
  while idx <= #params.diagnostics do
    if vim.tbl_contains(ignore_codes, params.diagnostics[idx].code) then
      table.remove(params.diagnostics, idx)
    else
      idx = idx + 1
      end 
      end
      end
      vim.lsp.diagnostic.on_publish_diagnostics(_, _, params, client_id, _, config)
      end,
},
--]=====]
}
EOF

lua << EOF
-- npm install -g diagnostic-languageserver eslint_d prettier_d_slim prettier
local function on_attach(client)
print('Attached to ' .. client.name)
end
local dlsconfig = require 'diagnosticls-configs'
dlsconfig.init {
default_config = false,
format = true,
on_attach = on_attach,
}
local eslint = require 'diagnosticls-configs.linters.eslint'
local prettier = require 'diagnosticls-configs.formatters.prettier'
prettier.requiredFiles = {
'.prettierrc',
'.prettierrc.json',
'.prettierrc.toml',
'.prettierrc.json',
'.prettierrc.yml',
'.prettierrc.yaml',
'.prettierrc.json5',
'.prettierrc.js',
'.prettierrc.cjs',
'prettier.config.js',
'prettier.config.cjs',
}
dlsconfig.setup {
['javascript'] = {
linter = eslint,
formatter = { prettier }
},
['javascriptreact'] = {
linter = { eslint },
formatter = { prettier }
},
['css'] = {
formatter = prettier
},
['html'] = {
formatter = prettier
},
}
EOF

nnoremap <silent> gd    <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> gh    <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gca   <cmd>:Telescope lsp_code_actions<CR>
nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> gR    <cmd>lua vim.lsp.buf.rename()<CR>
nnoremap <silent><leader>fo <cmd>lua vim.lsp.buf.formatting()<CR>

" autocmd BufWritePre *.js lua vim.lsp.buf.formatting()
" autocmd BufWritePre *.ts lua vim.lsp.buf.formatting()
" autocmd BufWritePre *.css lua vim.lsp.buf.formatting()

"TRouble plugin
lua << EOF
require 'trouble'.setup {}
EOF
nnoremap <leader>xx <cmd>TroubleToggle<cr>
nnoremap <leader>xw <cmd>TroubleToggle lsp_workspace_diagnostics<cr>
nnoremap <leader>xd <cmd>TroubleToggle lsp_document_diagnostics<cr>
nnoremap <leader>xq <cmd>TroubleToggle quickfix<cr>
nnoremap <leader>xl <cmd>TroubleToggle loclist<cr>
nnoremap gR <cmd>TroubleToggle lsp_references<cr>
" }}}

" 'williamboman/nvim-lsp-installer' {{{
lua << EOF
local lsp_installer = require("nvim-lsp-installer")
lsp_installer.on_server_ready(function(server)
local opts = {
capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
}
server:setup(opts)
end)
EOF
" }}}

" 'hrsh7th/nvim-cmp' {{{
lua <<EOF
-- Setup nvim-cmp.
local cmp = require'cmp'

cmp.setup({
auto_select = false,
snippet = {
expand = function(args)
require('luasnip').lsp_expand(args.body)
end,
},
mapping = {
['<Down>'] = cmp.mapping(cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }), {'i'}),
['<Up>'] = cmp.mapping(cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }), {'i'}),
['<C-y>'] = cmp.mapping.complete(),
['<Esc>'] = cmp.mapping.close(),
['<Tab>'] = cmp.mapping.confirm({
behavior = cmp.ConfirmBehavior.Replace,        
select = true
}),
['<CR>'] = cmp.mapping.confirm({
behavior = cmp.ConfirmBehavior.Replace,        
select = true
}),
},

completion = { completeopt = 'menu,menuone,noinsert' },
sources = {
{ name = 'nvim_lsp' },
-- For vsnip user.
-- { name = 'vsnip' },
-- For luasnip user.
{ name = 'path' },
-- For ultisnips user.
-- { name = 'ultisnips' },
{ name = 'luasnip' },
{ name = 'buffer', keywork_length = 5 },
{ name = 'npm', keyword_length = 4 },
},
formatting = {
-- format = require('lspkind').cmp_format {
--   with_text = true,
--   menu = {
--     buffer = "[buf]",
--     nvim_lsp = "[LSP]",
--     path = "[path]",
--     luasnip = "[snip]"
--   }
-- }
},
experimental = {
native_menu = false,
ghost_text = true
}
})
EOF

