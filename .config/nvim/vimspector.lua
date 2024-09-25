vim.cmd([[
nmap <leader>ds <cmd>call vimspector#Launch()<cr>
nmap <leader>dr <cmd>call vimspector#Reset()<cr>
nmap <leader>dn <cmd>call vimspector#StepOver()<cr>")
nmap <leader>do <cmd>call vimspector#StepOut()<cr>")
nmap <leader>di <cmd>call vimspector#StepInto()<cr>")
nmap <leader>db <cmd>call vimspector#ToggleBreakpoint()<cr>")
nmap <leader>dw <cmd>call vimspector#AddWatch()<cr>")
nmap <leader>de <cmd>call vimspector#Evaluate()<cr>")
]])
