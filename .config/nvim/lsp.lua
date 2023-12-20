require('mason').setup()
require('mason-lspconfig').setup()
local lsp_config = require('lspconfig')
-- LSP Diagnostics Options Setup
local sign = function(opts)
    vim.fn.sign_define(opts.name, {
        texthl = opts.name,
        text = opts.text,
        numhl = ''
    })
end


sign({ name = 'DiagnosticSignError', text = '' })
sign({ name = 'DiagnosticSignWarn', text = '' })
sign({ name = 'DiagnosticSignHint', text = '' })
sign({ name = 'DiagnosticSignInfo', text = '' })

vim.diagnostic.config({
    virtual_text = false,
    signs = true,
    update_in_insert = true,
    underline = true,
    severity_sort = false,
    float = {
        border = 'rounded',
        source = 'always',
        header = '',
        prefix = '',
    },
})

vim.cmd([[
set signcolumn=yes
autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false })
]])
-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap = false, silent = true }
vim.api.nvim_set_keymap('n', '<leader>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer

local on_attach = function(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wl',
        '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>a', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>f', '<cmd>lua vim.lsp.buf.format()<CR>', opts)
    if client.server_capabilities.inlayHintProvider then
        vim.lsp.buf.inlay_hints(bufnr, true)
    end
end

-- Setup lspconfig.
local capabilities = require('cmp_nvim_lsp').default_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
local servers = { 'zls', "pylsp", "clangd", "omnisharp_mono", "ols", "lua_ls" }
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

local rt = require("rust-tools")
rt.setup(
    {
        tools =
        {
            reload_workspace_from_cargo_toml = true,

            crate_graph =
            {
                full = false,
            },
        },
        server =
        {
            on_attach = function(_, bufnr)
                -- Hover actions
                vim.api.nvim_buf_set_keymap(bufnr, "n", "<C-a>",
                    "<cmd> lua require('rust-tools').hover_actions.hover_actions()<CR>", opts)
                vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>run",
                    "<cmd> lua require('rust-tools').runnables.runnables()<CR>", opts)
                vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>a', '<cmd>RustCodeAction<CR>', opts)
                vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
                vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
                vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
                vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
                vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>',
                    opts)
                vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wr',
                    '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
                vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wl',
                    '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
                vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
                vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
                vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
                vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>f', '<cmd>lua vim.lsp.buf.format()<CR>', opts)
            end,
        }
    }
)

rt.inlay_hints.enable()
local zt = require('zig-tools').setup()
-- local setup_jails = function()
--     vim.lsp.start({
--         cmd = { 'jails -jai_path ~/jai' },
--     })
-- end
-- local generalSettingsGroup = vim.api.nvim_create_augroup('General settings', { clear = true })
-- vim.api.nvim_create_autocmd('FileType', {
--     pattern = {'*.jai'},
--     callback = setup_jails,
--     group = generalSettingsGroup,
-- })
local configs = require 'lspconfig.configs'
if not configs.jails then
    configs.jails = {
        default_config = {
            cmd = { 'jails', ' -jai_path ~/jai'},
            filetypes = { 'jai' },
            root_dir = function(fname)
                return lsp_config.util.find_git_ancestor(fname)
            end,
            settings = {},
        },
    }
end
lsp_config.jails.setup({
    on_attach = on_attach,
    flags = {
        -- This will be the default in neovim 0.7+
        debounce_text_changes = 150,
    },
    capabilities = capabilities,
})
-- vim.tbl_deep_extend('keep', lsp_config, {
--     jails = {
--         cmd = { 'jails', ' -jai_path ~/jai' },
--         filetypes = { 'jai' },
--         root_dir = function(fname)
--             return lsp_config.util.find_git_ancestor(fname)
--         end,
--         settings = {},
--     }
-- })
