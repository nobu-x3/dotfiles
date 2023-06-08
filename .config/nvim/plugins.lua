require('packer').startup(function(use)
  -- Packer can manage itself
use 'wbthomason/packer.nvim'
use 'vim-airline/vim-airline-themes' -- the statusbar
use 'folke/tokyonight.nvim'
use 'tpope/vim-commentary'
use 'voldikss/vim-floaterm'
use 'Yggdroot/indentLine'
use 'williamboman/mason.nvim'
use 'williamboman/mason-lspconfig.nvim'
use 'neovim/nvim-lspconfig'
use 'kyazdani42/nvim-tree.lua'
use 'ggandor/leap.nvim'
use {'akinsho/bufferline.nvim', tag = "*", requires = 'nvim-tree/nvim-web-devicons'}
-- Rust:
use 'simrat39/rust-tools.nvim'
use 'rust-lang/rust.vim'
use 'rust-lang/rustfmt'
use 'nvim-treesitter/nvim-treesitter'

use 'akinsho/toggleterm.nvim'
use 'ziglang/zig.vim'
use 'NTBBloodbath/zig-tools.nvim'

-- nvim-cmp has a lot of dependencies
use 'hrsh7th/cmp-nvim-lsp'
use 'hrsh7th/cmp-buffer'
use 'hrsh7th/cmp-path'
use 'hrsh7th/cmp-cmdline'
use 'hrsh7th/nvim-cmp'
use 'hrsh7th/cmp-nvim-lsp-signature-help'

-- plugins for snippets
use 'L3MON4D3/LuaSnip'
use 'saadparwaiz1/cmp_luasnip'

-- telescope plugin and its dependencies
use 'nvim-lua/popup.nvim'
use 'nvim-lua/plenary.nvim'
use 'nvim-telescope/telescope.nvim' -- fuzzy finder

-- brackets
use 'windwp/nvim-autopairs'

-- bufferline
use 'kyazdani42/nvim-web-devicons' -- Recommended (for coloured icons)

-- session-manager
use 'Shatur/neovim-session-manager'

-- Debugger
use 'puremourning/vimspector'
use 'mfussenegger/nvim-dap'
end)


-- for autopairs
require('nvim-autopairs').setup{}


-- neovim tree
require'nvim-tree'.setup {
}

require('leap').add_default_mappings()

-- session manager
require('session_manager').setup({
    autoload_mode = require('session_manager.config').AutoloadMode.Disabled,
    autosave_last_session = false,
})

vim.opt.termguicolors = true
require("bufferline").setup{}
vim.cmd([[
let g:zig_fmt_autosave = 1
" Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect
" Enable completions as you type
let g:completion_enable_auto_popup = 1
]])
