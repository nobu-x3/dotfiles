require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'
    use 'vim-airline/vim-airline-themes' -- the statusbar
    use 'folke/tokyonight.nvim'
    use({
        'rose-pine/neovim',
        as = 'rose-pine',
        config = function()
            vim.cmd('colorscheme rose-pine')
        end
    })
    use({
        'bluz71/vim-moonfly-colors',
        as = 'moonfly',
        config = function()
            vim.cmd('colorscheme moonfly')
        end
    })
    use 'tpope/vim-commentary'
    use 'Yggdroot/indentLine'
    use 'williamboman/mason.nvim'
    use 'williamboman/mason-lspconfig.nvim'
    use 'neovim/nvim-lspconfig'
    use 'kyazdani42/nvim-tree.lua'
    use 'ggandor/leap.nvim'
    use { 'akinsho/bufferline.nvim', tag = "*", requires = 'nvim-tree/nvim-web-devicons' }
    -- Rust:
    use 'simrat39/rust-tools.nvim'
    use 'rust-lang/rust.vim'
    use 'rust-lang/rustfmt'
    use 'nvim-treesitter/nvim-treesitter'

    -- Jai:
    use 'rluba/jai.vim'

    use { "akinsho/toggleterm.nvim", tag = '*', config = function()
        require("toggleterm").setup()
    end }
    use 'ziglang/zig.vim'

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

    use 'nvim-pack/nvim-spectre'
    -- brackets
    use 'windwp/nvim-autopairs'

    -- bufferline
    use 'kyazdani42/nvim-web-devicons' -- Recommended (for coloured icons)

    -- session-manager
    use 'Shatur/neovim-session-manager'

    -- Debugger
    use 'puremourning/vimspector'
    use 'mfussenegger/nvim-dap'
    use 'MunifTanjim/nui.nvim'
    use 'rcarriga/nvim-notify'
end)


-- for autopairs
require('nvim-autopairs').setup {}


-- neovim tree
require 'nvim-tree'.setup {
}

require('leap').add_default_mappings()

-- session manager
require('session_manager').setup({
    autoload_mode = require('session_manager.config').AutoloadMode.Disabled,
    autosave_last_session = false,
})

vim.opt.termguicolors = true
require("bufferline").setup {}
vim.cmd([[
let g:zig_fmt_autosave = 1
" Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect
" Enable completions as you type
let g:completion_enable_auto_popup = 1
]])
vim.keymap.set('n', '<leader>S', '<cmd>lua require("spectre").toggle()<CR>', {
    desc = "Toggle Spectre"
})
vim.keymap.set('n', '<leader>sw', '<cmd>lua require("spectre").open_visual({select_word=true})<CR>', {
    desc = "Search current word"
})
vim.keymap.set('v', '<leader>sw', '<esc><cmd>lua require("spectre").open_visual()<CR>', {
    desc = "Search current word"
})
vim.keymap.set('n', '<leader>sp', '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>', {
    desc = "Search on current file"
})
