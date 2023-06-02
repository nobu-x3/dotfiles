require('packer').startup(function(use)
  -- Packer can manage itself
use 'wbthomason/packer.nvim'
use 'vim-airline/vim-airline-themes' -- the statusbar
use 'folke/tokyonight.nvim'
use 'tpope/vim-commentary'
use 'voldikss/vim-floaterm'
use 'folke/tokyonight.nvim'
use 'Yggdroot/indentLine'
use 'williamboman/mason.nvim'
use 'williamboman/mason-lspconfig.nvim'
use 'neovim/nvim-lspconfig'
use 'kyazdani42/nvim-tree.lua'
use 'mhartington/formatter.nvim'
use 'ggandor/leap.nvim'
use {'akinsho/bufferline.nvim', tag = "*", requires = 'nvim-tree/nvim-web-devicons'}
-- Rust:
use 'simrat39/rust-tools.nvim'
use 'rust-lang/rust.vim'
use 'rust-lang/rustfmt'
use 'nvim-treesitter/nvim-treesitter'

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

-- Utilities for creating configurations
local util = require "formatter.util"

-- Provides the Format, FormatWrite, FormatLock, and FormatWriteLock commands
require("formatter").setup {
  -- Enable or disable logging
  logging = false,
  -- All formatter configurations are opt-in
  filetype = {
    -- Formatter configurations for filetype "lua" go here
    -- and will be executed in order
    lua = {
      -- "formatter.filetypes.lua" defines default configurations for the
      -- "lua" filetype
      require("formatter.filetypes.lua").stylua,

      -- You can also define your own configuration
      function()
        -- Supports conditional formatting
        if util.get_current_buffer_file_name() == "special.lua" then
          return nil
        end

        -- Full specification of configurations is down below and in Vim help
        -- files
        return {
          exe = "stylua",
          args = {
            "--search-parent-directories",
            "--stdin-filepath",
            util.escape_path(util.get_current_buffer_file_path()),
            "--",
            "-",
          },
          stdin = true,
        }
      end
    },

    c = {
        function()
            return {
                exe = "clang-format",
                args = {
                        "--style=file:.clang_format",
                        util.escape_path(util.get_current_buffer_file_name()),
                },
                stdin = true
            }
        end
    },

    -- Use the special "*" filetype for defining formatter configurations on
    -- any filetype
    ["*"] = {
      -- "formatter.filetypes.any" defines default configurations for any
      -- filetype
      require("formatter.filetypes.any").remove_trailing_whitespace
    }
  }
}
vim.opt.termguicolors = true
require("bufferline").setup{}
