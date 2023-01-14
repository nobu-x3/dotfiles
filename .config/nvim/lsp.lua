require('mason').setup()
require('mason-lspconfig').setup()
-- require'lspconfig'.pyright.setup{}
-- require'lspconfig'.gdscript.setup{}
-- require'lspconfig'.clangd.setup{}

-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap=true, silent=true }
vim.api.nvim_set_keymap('n', '<leader>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
-- vim.api.nvim_set_keymap('n', '<leader>test', "<cmd>lua require'gen-def'.paste_to_cpp_file()<CR>", opts)
vim.api.nvim_set_keymap('n', '<leader>test', "<cmd>lua require'gen-def'.test()<CR>", opts)
-- vim.api.nvim_set_keymap('n', '<leader>print', "<cmd>lua print(require'gen-def'.cpp_generate_body())<CR>", opts)
vim.api.nvim_set_keymap('n', '<leader>print', "<cmd>lua print(require'gen-def'.list_buffers())<CR>", opts)
-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<c-a>', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'cf', '<cmd>lua vim.lsp.buf.format()<CR>', opts)
end

-- Setup lspconfig.
local capabilities = require('cmp_nvim_lsp').default_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
-- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
-- local capabilities = vim.lsp.protocol.make_client_capabilties()

-- require'lspconfig'.clangd.setup{
--    }

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches

-- local filetypes = { "c", "cpp", "objc", "objcpp", "opencl" }
-- local server_config = {
--     -- Sidebar configuration
--     sidebar = {
--         size = 50,
--         position = "topleft",
--         split = "vnew",
--         width = 50,
--         height = 20,
--     },
--     -- floating window configuration. check :help nvim_open_win for options
--     float = {
--         style = "minimal",
--         relative = "cursor",
--         width = 50,
--         height = 20,
--         row = 0,
--         col = 0,
--         border = "rounded",
--     },
--     filetypes = filetypes,
--     init_options = { cache = {
--         directory = vim.fs.normalize "~/.cache/ccls/",
--     } },
--     name = "ccls",
--     cmd = { "ccls" },
--     offset_encoding = "utf-32",
--     root_dir = vim.fs.dirname(
--         vim.fs.find({ "compile_commands.json", "compile_flags.txt", ".git" }, { upward = true })[1]
--     ),
-- }
-- require("ccls").setup {
--     filetypes = filetypes,
--     lsp = {
--         server = server_config,
--         codelens = { enable = true }
--     },
--     on_attach = on_attach
-- }

local servers = {'zls', "pylsp", "sumneko_lua", "clangd"}
for _, lsp in pairs(servers) do
  require('lspconfig')[lsp].setup {
    on_attach = on_attach,
    flags = {
      -- This will be the default in neovim 0.7+
      debounce_text_changes = 150,
    },
    capabilities = capabilities,
  }
end
