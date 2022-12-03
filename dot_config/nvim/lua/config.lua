require 'nvim-treesitter.install'.compilers = { "clang" }

-- for autopairs
require('nvim-autopairs').setup{}

-- for bufferline
require("bufferline").setup{
    options = {
        show_buffer_close_icons = false,
    }
}

-- neovim tree
require'nvim-tree'.setup {
}

