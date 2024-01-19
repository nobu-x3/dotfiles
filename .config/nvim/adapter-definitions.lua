local dap = require('dap')
dap.adapters.cppdbg = {
  id = 'cppdbg',
  type = 'executable',
  command = '/usr/bin/gdb',
}

dap.adapters.lldb = {
    type = "executable",
    command = '/usr/bin/lldb',
    name = 'lldb',
}

dap.configurations.cpp = {
  {
    name = "Launch file",
    type = "cppdbg",
    request = "launch",
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopAtEntry = true,
  },
  {
    name = 'Attach to gdbserver :1234',
    type = 'cppdbg',
    request = 'launch',
    MIMode = 'gdb',
    miDebuggerServerAddress = 'localhost:1234',
    miDebuggerPath = '/usr/bin/gdb',
    cwd = '${workspaceFolder}',
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
  },
}
-- dap.configurations.jai = {
--   {
--     name = "Launch lldb",
--     type = "lldb",
--     request = "launch",
--     program = function()
--       return vim.fn.input('Path to executable: ', 'bin/' .. vim.fn.getcwd() .. '/', 'file')
--     end,
--     cwd = '${workspaceFolder}/bin',
--     stopAtEntry = false,
--     args = {},
--     runInTerminal = false,
--   },
-- }
