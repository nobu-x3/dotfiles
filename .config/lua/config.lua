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

local ts_utils = require 'nvim-treesitter.ts_utils'

local M = {}

function M.cpp_generate_body()
    local current_node = ts_utils.get_node_at_cursor()

    local function_info = nil
    local parts = {}

    while current_node ~= nil do
        local type = current_node:type()
        if (type == 'field_declaration' or type == 'function_definition' or type == 'declaration') and not function_info then
            function_info = { return_type = '', declaration = nil }
            for node, name in current_node:iter_children() do
                if node:named() then
                    if name == 'type' then
                        function_info.return_type = vim.treesitter.query.get_node_text(node, 0)
                    elseif name == 'declarator' then
                        function_info.declaration = vim.treesitter.query.get_node_text(node, 0)
                    end
                end
            end
        elseif type == 'struct_specifier' or type == 'class_specifier' or type == 'namespace_definition' then
            if not function_info then
                -- no function found
                return ''
            end
            for node, name in current_node:iter_children() do
                if node:named() then
                    if name == 'name' then
                        table.insert(parts, 1, vim.treesitter.query.get_node_text(node, 0))
                    end
                end
            end
        end
        current_node = current_node:parent()
    end

    if not function_info then
        return ''
    end
    -- is not the destructor and the return type is a pointer of a reference
    local found, _, prefix, name = function_info.declaration:find('^(%W+)%s*(%w.*)')
    if found and prefix ~= '~' then
        function_info.return_type = function_info.return_type .. prefix
        function_info.declaration = name
    end

    local specifier = table.concat(parts, '::')

    if specifier:len() > 0 then
        specifier = specifier .. '::' .. function_info.declaration
    else
        specifier = function_info.declaration
    end

    if function_info.return_type:len() > 0 then
        function_info.return_type = function_info.return_type .. ' '
    end

    local definition = string.format("%s%s", function_info.return_type, specifier)

    -- remove override and multiple spaces
    return definition:gsub('^(.+)%)(.*)override(.*)', '%1)%2 %3'):gsub('%s+', ' ') .. "\n{\n}\n"
end

return M
