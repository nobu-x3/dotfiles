vim.cmd([[
nmap <F5> <cmd>call vimspector#Launch()<cr>
nmap <F8> <cmd>call vimspector#Reset()<cr>
nmap <F10> <cmd>call vimspector#StepOver()<cr>")
nmap <F12> <cmd>call vimspector#StepOut()<cr>")
nmap <F11> <cmd>call vimspector#StepInto()<cr>")
nmap Db <cmd>call vimspector#ToggleBreakpoint()<cr>")
nmap Dw <cmd>call vimspector#AddWatch()<cr>")
nmap De <cmd>call vimspector#Evaluate()<cr>")
]])
