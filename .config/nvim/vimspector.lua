vim.cmd([[
nmap <F5> <cmd>call vimspector#Launch()<cr>
nmap <F8> <cmd>call vimspector#Reset()<cr>
nmap <F10> <cmd>call vimspector#StepOver()<cr>")
nmap <F12> <cmd>call vimspector#StepOut()<cr>")
nmap <F11> <cmd>call vimspector#StepInto()<cr>")
nmap <leader>db <cmd>call vimspector#ToggleBreakpoint()<cr>")
nmap <leader>dw <cmd>call vimspector#AddWatch()<cr>")
nmap <leader>de <cmd>call vimspector#Evaluate()<cr>")
]])
