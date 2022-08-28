"  neovide
if exists("g:neovide")
    let g:neovide_cursor_vfx_mode = ""
    "let g:neovide_transparency=0.8
    let g:neovide_scroll_animation_length= 0 "0.02
    let g:neovide_cursor_animation_length=0 "0.02
    let g:neovide_cursor_trail_length=0.0
    let g:neovide_cursor_unfocused_outline_width=0.125
    let g:neovide_cursor_vfx_mode = ""
    let g:neovide_fullscreen=v:true
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
set cursorline
set encoding=utf-8
"  Use clipboard for cut and paste
set clipboard+=unnamedplus

"  paste from clipboard into command line
map! <S-Insert> <C-R>+
map! <C-v> <C-R>+

lua require('plugins')
lua require('keybindings')

set guifont=Fira\ Mono\ Medium:h12.5

"  save
noremap <silent> <C-S>          :update<CR>
vnoremap <silent> <C-S>         <C-C>:update<CR>
inoremap <silent> <C-S>         <C-O>:update<CR>
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
