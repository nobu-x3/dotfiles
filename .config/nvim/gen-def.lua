local ts_utils = require 'nvim-treesitter.ts_utils'

local M = {}

function M.switch_source_header(bufnr)
  local util = require'lspconfig.util'
  bufnr = util.validate_bufnr(bufnr)
  local clangd_client = util.get_active_client_by_name(bufnr, 'clangd')
  local params = { uri = vim.uri_from_bufnr(bufnr) }
  local line = M.cpp_generate_body()
  if clangd_client then
    clangd_client.request('textDocument/switchSourceHeader', params,
    function(err, result)
      if err then
        error(tostring(err))
      end
      if not result then
        print 'Corresponding file cannot be determined'
        return
      end
      vim.api.nvim_command('edit ' .. vim.uri_to_fname(result))
      print(M.get_buffer_by_filename(result))
      -- M.paste_to_cpp_file(line)
      -- print(line)
    end, bufnr)
  else
    print 'method textDocument/switchSourceHeader is not supported by any servers active on the current buffer'
  end
  print(line)
end

function M.get_buffer_by_filename(name)
    local buffers = vim.api.nvim_list_bufs()
    for _, buffer in ipairs(buffers) do
        if vim.api.nvim_buf_get_name(buffer) == name then
            return buffer
        end
    end
    return -5
end

function M.list_buffers()
    -- local buffers = vim.api.nvim_list_bufs()
    -- for _, buffer in ipairs(buffers) do
    --     local name = vim.api.nvim_buf_get_name(buffer)
    --     print(name)
    -- end
    -- local buffer = vim.api.nvim_win_get_buf(0)
    -- local name = vim.api.nvim_buf_get_name()
    M.switch_source_header(0)
end

function M.paste_to_cpp_file(line)
    -- local line = M.cpp_generate_body();
    local split = {}
    -- local bufnr = require'lspconfig.util'.validate_bufnr(0)
    for k, v in string.gmatch(line, "\n") do
        split[k] = v
        -- print(v)
    end
    -- local file_name = vim.fn.expand('%:r')
    -- vim.api.nvim_command('ClangdSwitchSourceHeader')
    -- if(file_name = vim.fn.expand('%:r'))
    -- then
        -- vim.api.nvim_command('vsp ' .. file_name .. '.cpp')
    -- end
    -- local buf_line_count = vim.api.nvim_buf_line_count(bufnr)
    -- print(vim.api.nvim_buf_get_name(bufnr))
    -- local count  = select(2, str:gsub(line, '\n'))

    vim.api.nvim_buf_set_lines(0, -1, -1, false, split)
end

function M.test()
    M.paste_to_cpp_file()

    local bufnr = vim.api.nvim_get_current_buf()
    local buf_line_count = vim.api.nvim_buf_line_count(bufnr)
    print(vim.api.nvim_buf_get_name(bufnr))
end

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
      if definition:find(" = (.+),") then
        definition = definition:gsub(" = (.+),", ",")
      end
    -- remove override and multiple spaces
    return definition:gsub('^(.+)%)(.*)override(.*)', '%1)%2 %3'):gsub('%s+', ' ') .. "\n{\n}\n"
end

return M
