:set autoindent
:set tabstop=4
:set shiftwidth=4
:set smarttab
:set softtabstop=4
:set mouse=a
:set ignorecase
:set encoding=utf-8
:set nobackup
:set nowritebackup
:set updatetime=300
:set signcolumn=yes
let g:OmniSharp_server_use_mono = 1
:set autoread
:set termguicolors

:set number
:augroup numbertoggle
:  autocmd!
:  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif
:  autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif
:augroup END
call plug#begin()

Plug 'vim-airline/vim-airline'
Plug 'preservim/nerdtree'  
Plug 'voldikss/vim-floaterm'
Plug 'neoclide/coc.nvim'
Plug 'OmniSharp/omnisharp-vim'
Plug 'dense-analysis/ale'
Plug 'BurntSushi/ripgrep'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', {'branch' : '0.1.x'}
Plug 'nvim-treesitter/nvim-treesitter' 
Plug 'ziglang/zig.vim'
Plug 'morhetz/gruvbox'
Plug 'jiangmiao/auto-pairs'
Plug 'puremourning/vimspector'
Plug 'morhetz/gruvbox'
Plug 'akinsho/nvim-toggleterm.lua'
Plug 'kyazdani42/nvim-web-devicons' " Recommended (for coloured icons)
Plug 'akinsho/bufferline.nvim'
call plug#end()

autocmd VimEnter * TSEnable highlight
:set background=dark
let g:gruvbox_contrast_dark = 'hard'
let g:gruvbox_transparent_bg = 1
:colorscheme gruvbox
hi! Normal ctermbg=NONE guibg=NONE
hi! NonText ctermbg=NONE guibg=NONE
"" COC START ================================================
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
"" COC END ==================================================

" Telescope and NT bindings
nnoremap ff <cmd>Telescope find_files<cr>
nnoremap fg <cmd>Telescope live_grep<cr>
nnoremap fb <cmd>Telescope buffers<cr>
nnoremap fh <cmd>Telescope help_tags<cr>
nnoremap <C-n> <cmd> NERDTree<cr>

" Clipboard
noremap <leader>p :-1r !xclip -o -sel clip<CR>
noremap <leader>y :'<,'>w !xclip -selection clipboard<CR><CR>

" Buffers instead of tabs
nmap <silent>gt :bn<CR>
nmap <silent>gT :bp<CR>
nmap <C-q> :bp <BAR> bd #<CR>
nmap <leader>bl :buffers<cr>:b<space>

let g:airline_theme = 'gruvbox'
let g:airline#extensions#tabline#enabled = 0
let g:airline#extensions#tabline#fnamemod = ':t'

let g:floaterm_winblend = 8

nnoremap   <silent>   <F1>   :FloatermNew<CR>
tnoremap   <silent>   <F1>   <C-\><C-n>:FloatermNew<CR>
nnoremap   <silent>   <F2>   :FloatermNext<CR>
tnoremap   <silent>   <F2>  <C-\><C-n>:FloatermNext<CR>
nnoremap   <silent>   ,t   :FloatermToggle<CR>
tnoremap   <silent>   <Esc><Esc>   <C-\><C-n>:FloatermToggle<CR>
tnoremap   <silent>   <F3>   <C-\><C-n>:FloatermKill<CR>
"" let g:everforest_background = 'soft'
let g:ale_linters = { 'cs': ['omnisharp'] }
"" VIMSPECTOR START ========================================
let g:vimspector_enable_mappings = 'VISUAL_STUDIO'
""packadd! vimspector
let g:vimspector_install_gadgets = [ 'netcoredbg', 'vscode-cpptools' ]
" for normal mode - the word under the cursor
nmap <Leader>di <Plug>VimspectorBalloonEval
" for visual mode, the visually selected text
xmap <Leader>di <Plug>VimspectorBalloonEval
"" VIMSPECTOR END ==========================================
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> [d <Plug>(coc-diagnostic-prev)
nmap <silent> ]d <Plug>(coc-diagnostic-next)

" Use K to show documentation in preview window.
nnoremap <silent> K :call ShowDocumentation()<CR>
function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction	

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')
" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)
nmap <silent>gh :CocCommand clangd.switchSourceHeader<CR>
"nnoremap <silent> <C-A> <cmd>OmniSharpGetCodeActions<cr>
" Remap keys for applying codeAction to the current buffer.
nmap <silent> <C-a> <Plug>(coc-codeaction)
imap <silent> <C-a> <Plug>(coc-codeaction)
inoremap <expr> <cr> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"
if has('nvim')
	inoremap <silent><expr> <c-space> coc#refresh()
else
	inoremap <silent><expr> <c-@> coc#refresh()
endif
nmap <silent>cf :pyf /usr/share/clang/clang-format.py<cr>

function! Formatonsave()
  let l:formatdiff = 1
  pyf /usr/share/clang/clang-format.py
endfunction
autocmd BufWritePre *.h,*.cc,*.cpp call Formatonsave()
syntax on

lua require('config')
lua require('tree_sitter')
lua require('dap-adapter')
lua require('dap-configuration')
