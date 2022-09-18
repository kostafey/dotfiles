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

" show line numbers
set number
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
autocmd InsertEnter * highlight  CursorLine guibg=#D3F0D5
" Revert Color to default when leaving Insert Mode
autocmd InsertLeave * highlight  CursorLine guibg=#F2FFC0

set encoding=utf-8
"  Use clipboard for cut and paste
set clipboard+=unnamedplus

"  paste from clipboard into command line
map! <S-Insert> <C-R>+
map! <C-v> <C-R>+

let g:aniseed#env = v:true
lua require('plugins')
lua require('keybindings')
lua require('commands')

set guifont=Fira\ Mono\ Medium:h12.5:cDEFAULT
autocmd BufRead,BufNewFile * syn match parens /[(){}]/ | hi parens ctermfg=red

"  copy current file path
nnoremap cp :let @+=expand('%:p')<CR>

"  findWordAtCursor.previous
noremap <C-M-Up> g#:let @/ = ""<CR>
vnoremap <C-M-Up> <C-C>g#:let @/ = ""<CR>v
inoremap <C-M-Up> <C-C>g#:let @/ = ""<CR>i
"  findWordAtCursor.next
noremap <C-M-Down> g*:let @/ = ""<CR>
vnoremap <C-M-Down> <C-C>g*:let @/ = ""<CR>v
inoremap <C-M-Down> <C-C>g*:let @/ = ""<CR>i

"  arrow key mappings for wildmenu tab completion
set wildcharm=<C-Z>
cnoremap <expr> <up> wildmenumode() ? "\<left>" : "\<up>"
cnoremap <expr> <down> wildmenumode() ? "\<right>" : "\<down>"
cnoremap <expr> <left> wildmenumode() ? "\<up>" : "\<left>"
cnoremap <expr> <right> wildmenumode() ? " \<bs>\<C-Z>" : "\<right>"

" Confirm save changes
set confirm
