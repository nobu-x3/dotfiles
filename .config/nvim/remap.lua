vim.g.mapleader = " "

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
-- Open corresponding .pdf/.html or preview
vim.keymap.set("n", "<leader>0", ":!opout <c-r>%<CR>")
-- compile, make, create, do shit!
vim.keymap.set("n", "<leader>m", ":w! | !compiler '<c-r>%'")
vim.keymap.set("n", "<leader>fz", ":FZF<CR>")
-- external copy-paste
vim.keymap.set("n", "<leader>p", ":-1r !xclip -o -sel clip<CR>")
vim.keymap.set("n", "<leader>y", ":'<,'>w !xclip -selection clipboard<CR><CR>")
-- config for buffers
vim.keymap.set("n", "gt", ":bn<CR>")
vim.keymap.set("n", "gT", ":bp<CR>")
vim.keymap.set("n", "<C-q> :bp", "<BAR> bd #<CR>")
vim.keymap.set("n", "<leader>bl", ":buffers<cr>:b<space>")
-- Shortcutting split navigation
vim.keymap.set("n", "<A-h>", "<C-w>h")
vim.keymap.set("n", "<A-j>", "<C-w>j")
vim.keymap.set("n", "<A-k>", "<C-w>k")
vim.keymap.set("n", "<A-l>", "<C-w>l")
-- toggle term
vim.keymap.set("n", "<F2>", ":ToggleTerm<CR>")
vim.keymap.set("t", "<F2>", "<C-\\><C-n>:ToggleTerm<CR>")
-- nvim-telescope
vim.keymap.set("n", "ff", "<cmd>Telescope find_files<cr>")
vim.keymap.set("n", "fg", "<cmd>Telescope live_grep<cr>")
vim.keymap.set("n", "fb", "<cmd>Telescope buffers<cr>")
vim.keymap.set("n", "fh", "<cmd>Telescope help_tags<cr>")
-- nvim tree
vim.keymap.set("n", "<C-n>", ":NvimTreeToggle<CR>")
-- change this
-- nnoremap <leader>n :NvimTreeFindFile<CR> # to specific to have a keybinding for now

-- buffer pick
vim.keymap.set("n", "<leader>bb", "<cmd>BufferLinePick<cr>")
vim.keymap.set("n", "gb", ":BufferLinePick<CR>")
-- dap
vim.keymap.set("n", "<F9>", ":lua require('dap').toggle_breakpoint()<cr>")
vim.keymap.set("n", "<F5>", ":lua require('dap').continue()<cr>")
vim.keymap.set("n", "<F10>", ":lua require('dap').step_over()<cr>")
vim.keymap.set("n", "<F11>", ":lua require('dap').step_into()<cr>")
vim.keymap.set("n", "<F6>", ":lua require('dap').repl.open()<cr>")
