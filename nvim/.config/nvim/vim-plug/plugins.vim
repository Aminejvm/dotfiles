
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()

    "Theme
    Plug 'folke/tokyonight.nvim', { 'branch': 'main' }

    "Copilot
    " Plug 'github/copilot.vim'

    " Bufferline
    Plug 'akinsho/bufferline.nvim', { 'tag': 'v3.*' }

    "LSP
    Plug 'neovim/nvim-lspconfig'
    Plug 'williamboman/nvim-lsp-installer'
    Plug 'folke/trouble.nvim'
    Plug 'onsails/lspkind-nvim'
    Plug 'creativenull/diagnosticls-configs-nvim'
    Plug 'sbdchd/neoformat'

    " Treesitter
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
    Plug 'nvim-treesitter/nvim-treesitter-textobjects'

    " https://github.com/nvim-treesitter/nvim-treesitter/issues/1111
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
    Plug 'JoosepAlviste/nvim-ts-context-commentstring'
    Plug 'MaxMEllon/vim-jsx-pretty' " fix indentation in jsx until treesitter can
    Plug 'jxnblk/vim-mdx-js'

    " Completion
    Plug 'hrsh7th/nvim-cmp'
    Plug 'hrsh7th/cmp-buffer'
    Plug 'hrsh7th/cmp-path'
    Plug 'hrsh7th/cmp-nvim-lsp'
    Plug 'L3MON4D3/LuaSnip'
    Plug 'saadparwaiz1/cmp_luasnip'
    Plug 'David-Kunz/cmp-npm'

    " Telescope
    Plug 'nvim-telescope/telescope.nvim'
    Plug 'nvim-lua/plenary.nvim'

    "Better Syntax Support
    Plug 'sheerun/vim-polyglot'
    " File Explorer
    Plug 'scrooloose/NERDTree'
    " Auto pairs for '(' '[' '{'
    Plug 'jiangmiao/auto-pairs'
    " Surround 
    Plug 'tpope/vim-surround'
    " Comment 
    Plug 'tpope/vim-commentary'
    " Styled components
    Plug 'styled-components/vim-styled-components'
    " To make it hard for myself
    Plug 'takac/vim-hardtime'
    " Dashboard
    Plug 'glepnir/dashboard-nvim'
    Plug 'alvan/vim-closetag'
    " Smooth scroll
    Plug 'yuttie/comfortable-motion.vim'
    " Scrollbar
    Plug 'petertriho/nvim-scrollbar'

    " Github Highlighting
    Plug 'lewis6991/gitsigns.nvim'
    " Tmux navigator
    Plug 'christoomey/vim-tmux-navigator'
    " Vim Script
    Plug 'kyazdani42/nvim-web-devicons'
    Plug 'folke/trouble.nvim'
    " Lualine
    Plug 'nvim-lualine/lualine.nvim'
    " Luanine icons
    Plug 'kyazdani42/nvim-web-devicons'
    " Vim context
    Plug 'wellle/context.vim'
    " Make it rain
    Plug 'eandrju/cellular-automaton.nvim'

call plug#end()

autocmd VimEnter *
  \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \|   PlugInstall --sync | q
  \| endif

