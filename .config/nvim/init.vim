"
"     nvim configs
" ####################

set nu
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set wrap!
set smartindent
set hlsearch!
set incsearch
set termguicolors
set signcolumn
set scrolloff=8
set clipboard=unnamedplus
set cursorline
set foldmethod=indent
set foldlevelstart=99
let mapleader = " "

if has('win32')
    luafile ~\AppData\Local\nvim\plugins.lua
endif

if has('unix')
    luafile ~/.config/nvim/plugins.lua
endif

:set number
:augroup numbertoggle
:  autocmd!
:  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif
:  autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif
:augroup END

" Automatically deletes all trailing whitespace and newlines at end of file on save.
autocmd BufWritePre * %s/\s\+$//e
autocmd BufWritePre * %s/\n\+\%$//e
function FormatBuffer()
if &modified && !empty(findfile('.clang_format', expand('%:p:h') . ';'))
let cursor_pos = getpos('.')
:%!clang-format --style=file:.clang_format
call setpos('.', cursor_pos)
endif
endfunction

autocmd BufWritePre *.h,*.hpp,*.c,*.cpp,*.vert,*.frag :call FormatBuffer()
" muh plugins

augroup qs_colors
    autocmd!
    autocmd ColorScheme * highlight QuickScopePrimary guifg='#afff5f' gui=underline ctermfg=155 cterm=underline
    autocmd ColorScheme * highlight QuickScopeSecondary guifg='#5fffff' gui=underline ctermfg=81 cterm=underline
augroup END
" Enables tree sitter
autocmd VimEnter * TSEnable highlight
" fzf-vim
set rtp+=/bin/


" run python scripts
" autocmd FileType python map <buffer> <F9> :w<CR>:exec '!python3' shellescape(@%, 1)<CR>
" autocmd FileType python imap <buffer> <F9> <esc>:w<CR>:exec '!python3' shellescape(@%, 1)<CR

" Basic Settings
set noshowmode
set number relativenumber

""" For Plugins

" " floaterm configs
" let g:floaterm_winblend = 8

"nnoremap   <silent>   <F2>   :ToggleTerm<CR>
"tnoremap   <silent>   <F2>   <C-\><C-n>:ToggleTerm<CR>
" nnoremap   <silent>   <F2>   :FloatermNew<CR>
" tnoremap   <silent>   <F2>   <C-\><C-n>:FloatermNew<CR>
" nnoremap   <silent>   <F3>   :FloatermNext<CR>
" tnoremap   <silent>   <F3>  <C-\><C-n>:FloatermNext<CR>
" nnoremap   <silent>   ,t   :FloatermToggle<CR>
" tnoremap   <silent>   <Esc><Esc>   <C-\><C-n>:FloatermToggle<CR>
" tnoremap   <silent>   <F4>   <C-\><C-n>:FloatermKill<CR>


" hexokinase configs
nnoremap <F12> :HexokinaseToggle<CR>

let g:Hexokinase_highlighters = [ 'backgroundfull' ]
let g:Hexokinase_refreshEvents = ['InsertLeave']

let g:Hexokinase_optInPatterns = [
  \     'full_hex',
  \     'triple_hex',
  \     'rgb',
  \     'rgba',
  \     'hsl',
  \     'hsla',
  \     'colour_names'
  \ ]

" scrape only these files for colour
" let g:Hexokinase_ftEnabled = ['css', 'html', 'javascript']

" vim airline
" let g:airline_theme = 'base16_dracula'
let g:airline#extensions#tabline#enabled = 0
let g:airline#extensions#tabline#fnamemod = ':t'

packadd! vimspector
" external config files (in lua)
if has('win32')
    luafile ~\AppData\Local\nvim\nvim-cmp.lua
    luafile ~\AppData\Local\nvim\lsp.lua
    " luafile ~\AppData\Local\nvim\ui.lua
    luafile ~\AppData\Local\nvim\treesitterconfig.lua
    luafile ~\AppData\Local\nvim\vimspector.lua
    luafile ~\AppData\Local\nvim\remap.lua
endif

if has('unix')
    luafile ~/.config/nvim/nvim-cmp.lua
    luafile ~/.config/nvim/lsp.lua
    " luafile ~/.config/nvim/ui.lua
    luafile ~/.config/nvim/treesitterconfig.lua
    luafile ~/.config/nvim/vimspector.lua
    luafile ~/.config/nvim/remap.lua
    " luafile ~/.config/nvim/adapter-definitions.lua
endif

" Exit Vim if NERDTree is the only window left.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() |
    \ quit | endif

" switch between header and src file in C++
autocmd FileType c,h,cpp,hpp nnoremap <buffer> <silent> gh :ClangdSwitchSourceHeader<CR>

let g:rustfmt_autosave = 1
syntax on
" indentLine char
let g:indentLine_char = '│'

" limit at 80 char
set colorcolumn=81
set completeopt=menuone,noinsert,noselect
" let g:completion_enable_auto_popup = 1
if exists("g:neovide")
    let g:neovide_refresh_rate = 120
    " set guifont=Source\ Code\ Pro:h12
    let g:neovide_cursor_animation_length = 0.04
    let g:neovide_cursor_trail_size = 0.2
    let g:neovide_cursor_antialiasing = v:true
endif
nnoremap - $
nnoremap _ ^
colorscheme moonfly
" menu guibg='black'
