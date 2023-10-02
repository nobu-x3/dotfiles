require("nvim-treesitter").setup()
require('nvim-treesitter.configs').setup({
    -- ...
    --nt_cpp_tools = {
    --    enable = true,
    --    preview = {
    --        quit = '<esc>', -- optional keymapping for quit preview
    --        accept = '<tab>' -- optional keymapping for accept preview
    --    },
    --    header_extension = 'h', -- optional
    --    source_extension = 'cpp', -- optional
    --    custom_define_class_function_commands = { -- optional
    --        TSCppImplWrite = {
    --            output_handle = require'nvim-treesitter.nt-cpp-tools.output_handlers'.get_add_to_cpp()
    --        }
    --        --[[
    --        <your impl function custom command name> = {
    --            output_handle = function (str, context)
    --                -- string contains the class implementation
    --                -- do whatever you want to do with it
    --            end
    --        }
    --        ]]
    --    }
    --},
    {

        ensure_installed = {"rust", "toml", "zig", "c"},
        auto_install = true,
        highlight = {enable = true, additional_vim_regex_highlighting = true},
        ident = {enable = true},
        rainbow = {
            enable = true,
            extended_mode = true,
            max_file_lines = nil,
        },
    }
})

-- Treesitter folding
vim.wo.foldmethod = 'expr'
vim.wo.foldexpr = 'nvim_treesitter#foldexpr()'
local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
parser_config.jai = {
  install_info = {
    url = "https://github.com/adragomir/tree-sitter-jai", -- local path or git repo
    files = {"src/parser.c"}, -- note that some parsers also require src/scanner.c or src/scanner.cc
    -- optional entries:
    branch = "master", -- default branch in case of git repo if different from master
    generate_requires_npm = false, -- if stand-alone parser without npm dependencies
    requires_generate_from_grammar = false, -- if folder contains pre-generated src/parser.c
  },
  filetype = "jai", -- if filetype does not match the parser name
}
