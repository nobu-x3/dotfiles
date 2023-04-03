-- {{ toggleterm
-- keymappings within toggleterm buffer
function _G.set_terminal_keymaps()
  local opts = {noremap = true}
  vim.api.nvim_buf_set_keymap(0, 't', '<esc>', [[<C-\><C-n>]], opts)
  vim.api.nvim_buf_set_keymap(0, 't', '<A-k>', [[<C-\><C-n><C-W>k]], opts)
  vim.api.nvim_buf_set_keymap(0, 't', '<C-c>t', [[<C-\><C-n>:ToggleTerm<CR>]], opts)
end

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

-- session manager
require('session_manager').setup({
    autoload_mode = require('session_manager.config').AutoloadMode.Disabled,
    autosave_last_session = false,
})
