"  neovide
if exists("g:neovide")
    let g:neovide_floating_window_opacity = 1.0
    let g:neovide_cursor_vfx_mode = ""
    "let g:neovide_transparency=0.8
    let g:neovide_scroll_animation_length= 0 "0.02
    let g:neovide_cursor_animation_length=0 "0.02
    let g:neovide_cursor_trail_length=0.0
    let g:neovide_cursor_unfocused_outline_width=0.125
    let g:neovide_cursor_vfx_mode = ""
    "let g:neovide_fullscreen=v:true
    let g:neovide_remember_window_size = v:true
    let g:neovide_remember_window_position = v:true
    "let g:neovide_cursor_antialiasing=v:true
endif

" Enable GUI ScrollBar
if exists(':GuiScrollBar')
    GuiScrollBar 1
endif

" show line numbers
set number
" Do not wrap long lines
set wrap!
" Position cursor to the most right char in command mode
set virtualedit=onemore
"  Set CUA mode
behave mswin
"  Enable mouse
set mouse=a

"  Insert mode cursor block shape
set guicursor=i:block
" Enable CursorLine
set cursorline

" Change Color when entering Insert Mode
" autocmd InsertEnter * highlight  CursorLine guibg=#D3F0D5
" Revert Color to default when leaving Insert Mode
" autocmd InsertLeave * highlight  CursorLine guibg=#F2FFC0

set encoding=utf-8
"  Use clipboard for cut and paste
set clipboard+=unnamedplus

" Load ~/.config/nvim/fnl/init.fnl
let g:aniseed#env = v:true
lua require('plugins')
lua require('commands')

set guifont=Fira\ Mono\ Medium:h12.5:cDEFAULT
" set guifont=FiraCode\ Nerd\ Font:h12.0:cDEFAULT
autocmd BufRead,BufNewFile * syn match parens /[(){}]/ | hi parens ctermfg=red

" Confirm save changes
set confirm
" Show filepath in window header 
set title
" Do not show -insert- in command line
set noshowmode
" Case insensitive search
set ignorecase
set smartcase

" tabstop:          Width of tab character
" softtabstop:      Fine tunes the amount of white space to be added
" shiftwidth        Determines the amount of whitespace to add in normal mode
" expandtab:        When this option is enabled, vi will use spaces instead of tabs
set tabstop     =4
set softtabstop =4
set shiftwidth  =4
set expandtab

set wildmenu
set wildmode=longest:full,full

