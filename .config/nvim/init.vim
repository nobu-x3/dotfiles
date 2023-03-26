"#####################
"     nvim configs
" ####################

set tabstop=4
set shiftwidth=4
set expandtab
set hidden
set foldmethod=syntax
set foldlevel=99
set clipboard=unnamedplus
set cursorline

:set number
:augroup numbertoggle
:  autocmd!
:  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif
:  autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif
:augroup END

" Automatically deletes all trailing whitespace and newlines at end of file on save.
autocmd BufWritePre * %s/\s\+$//e
autocmd BufWritePre * %s/\n\+\%$//e

" muh plugins
call plug#begin('~/.local/share/nvim/plugged')
Plug 'vim-airline/vim-airline' " the statusbar
Plug 'dracula/vim', { 'name': 'dracula' }
Plug 'morhetz/gruvbox' " theme
Plug 'tpope/vim-commentary'
Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' }
Plug 'voldikss/vim-floaterm'
Plug 'Yggdroot/indentLine'
Plug 'mhinz/vim-startify', {'branch': 'center'}
Plug 'airblade/vim-rooter' " replace with project.nvim soon
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'
Plug 'sakhnik/nvim-gdb'
Plug 'neovim/nvim-lspconfig'
Plug 'kyazdani42/nvim-tree.lua'
Plug 'ldelossa/nvim-ide'
Plug 'puremourning/vimspector'

" Rust:
Plug 'simrat39/rust-tools.nvim'
Plug 'rust-lang/rust.vim'
Plug 'rust-lang/rustfmt'
Plug 'nvim-treesitter/nvim-treesitter'
" Plug 'd0miKuras/nvim-treesitter-cpp-tools'

Plug 'ranjithshegde/ccls.nvim'

" nvim-cmp has a lot of dependencies
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp-signature-help'

Plug 'ziglang/zig.vim'

" plugins for snippets
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'

" telescope plugin and its dependencies
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim' " fuzzy finder

" kinda like vim-easymotion
Plug 'phaazon/hop.nvim'
" toggleable terminal within neovim
Plug 'akinsho/nvim-toggleterm.lua'

" brackets
Plug 'windwp/nvim-autopairs'

" bufferline
Plug 'kyazdani42/nvim-web-devicons' " Recommended (for coloured icons)
Plug 'akinsho/bufferline.nvim'

" session-manager
Plug 'Shatur/neovim-session-manager'

" Debugger
Plug 'mfussenegger/nvim-dap'
call plug#end()

augroup qs_colors
    autocmd!
    autocmd ColorScheme * highlight QuickScopePrimary guifg='#afff5f' gui=underline ctermfg=155 cterm=underline
    autocmd ColorScheme * highlight QuickScopeSecondary guifg='#5fffff' gui=underline ctermfg=81 cterm=underline
augroup END
" Enables tree sitter
autocmd VimEnter * TSEnable highlight
" fzf-vim
set rtp+=/bin/
noremap <leader>fz :FZF<cr>

" Replace all is aliased to S.
nnoremap S :%s//gc<Left><Left>

" Open corresponding .pdf/.html or preview
map <leader>0 :!opout <c-r>%<CR>

" compile, make, create, do shit!
map <leader>m :w! \| !compiler "<c-r>%"

" disabling auto-comment by default
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

""" external copy-paste
noremap <leader>p :-1r !xclip -o -sel clip<CR>
noremap <leader>y :'<,'>w !xclip -selection clipboard<CR><CR>

" floaterm for python console
" set splitbelow
" autocmd FileType python map <buffer> <F10> :w<CR> :split term://python %<CR>i
" autocmd FileType python map <buffer> <F10> :w<CR> :cd %:p:h <CR> :FloatermNew python %<CR>

" config for buffers
" nmap <leader>t :enew " i don't think i need this
nmap <silent>gt :bn<CR>
nmap <silent>gT :bp<CR>
nmap <C-q> :bp <BAR> bd #<CR>
nmap <leader>bl :buffers<cr>:b<space>

" run python scripts
" autocmd FileType python map <buffer> <F9> :w<CR>:exec '!python3' shellescape(@%, 1)<CR>
" autocmd FileType python imap <buffer> <F9> <esc>:w<CR>:exec '!python3' shellescape(@%, 1)<CR

" Basic Settings
colorscheme dracula
set noshowmode
set number relativenumber

" Shortcutting split navigation
map <A-h> <C-w>h
map <A-j> <C-w>j
map <A-k> <C-w>k
map <A-l> <C-w>l

" Enable and disable auto comment
" map <leader>c :setlocal formatoptions-=cro<CR>
" map <leader>C :setlocal formatoptions=cro<CR>

" Enable spell checking, s for spell check
map <leader>s :setlocal spell! spelllang=en_us<CR>

" Enable Disable Auto Indent
map <leader>i :setlocal autoindent<CR>
map <leader>I :setlocal noautoindent<CR>

""" For Plugins

" floaterm configs
let g:floaterm_winblend = 8

nnoremap   <silent>   <F1>   :FloatermNew<CR>
tnoremap   <silent>   <F1>   <C-\><C-n>:FloatermNew<CR>
nnoremap   <silent>   <F2>   :FloatermNext<CR>
tnoremap   <silent>   <F2>  <C-\><C-n>:FloatermNext<CR>
nnoremap   <silent>   ,t   :FloatermToggle<CR>
tnoremap   <silent>   <Esc><Esc>   <C-\><C-n>:FloatermToggle<CR>
tnoremap   <silent>   <F3>   <C-\><C-n>:FloatermKill<CR>

nnoremap <silent><F9> :lua require('dap').toggle_breakpoint()<cr>
nnoremap <silent><F5> :lua require('dap').continue()<cr>
nnoremap <silent><F10> :lua require('dap').step_over()<cr>
nnoremap <silent><F11> :lua require('dap').step_into()<cr>
nnoremap <silent><F6> :lua require('dap').repl.open()<cr>
" hexokinase configs
set termguicolors
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
let g:airline_theme = 'gruvbox'
let g:airline#extensions#tabline#enabled = 0
let g:airline#extensions#tabline#fnamemod = ':t'

" external config files (in lua)
lua  require("nvim-cmp")
lua require("lsp")
lua require("plugins")
" luafile ~/.config/nvim/adapter-definitions.lua
lua require("treesitterconfig")
lua require("vimspector")

" Exit Vim if NERDTree is the only window left.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() |
    \ quit | endif

" nvim-telescope
nnoremap ff <cmd>Telescope find_files<cr>
nnoremap fg <cmd>Telescope live_grep<cr>
nnoremap fb <cmd>Telescope buffers<cr>
nnoremap fh <cmd>Telescope help_tags<cr>

" buffer pick
nnoremap <leader>bb <cmd>BufferLinePick<cr>

nnoremap <silent> gb :BufferLinePick<CR>

" switch between header and src file in C++
autocmd FileType c,h,cpp,hpp nnoremap <buffer> <silent> gh :ClangdSwitchSourceHeader<CR>

" keybindings for nvimtree
nnoremap <C-n> :NvimTreeToggle<CR> " change this
" nnoremap <leader>n :NvimTreeFindFile<CR> # to specific to have a keybinding for now

function! Formatonsave()
  let l:formatdiff = 1
  pyf /usr/share/clang/clang-format.py
endfunction
autocmd BufWritePre *.h,*.cc,*.cpp call Formatonsave()
let g:rustfmt_autosave = 1
syntax on
" indentLine char
let g:indentLine_char = '│'

" limit at 80 char
set colorcolumn=81
set completeopt=menuone,noinsert,noselect
let g:completion_enable_auto_popup = 1
if exists("g:neovide")
    let g:neovide_refresh_rate = 60
    set guifont=Source\ Code\ Pro:h12
    let g:neovide_cursor_animation_length = 0.04
    let g:neovide_cursor_trail_size = 0.2
endif
