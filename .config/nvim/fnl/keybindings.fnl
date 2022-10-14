(module keybindings
  {require {nvim aniseed.nvim
            nu aniseed.nvim.util
            core aniseed.core}})

(local {: map
        : keys
        : str->chars} (require :lib))

(fn keymap [modes from to opts?]
  "Set keybindings."
  (let [options {:noremap true :silent true}]
    (when opts?
      (map (fn [k] (tset options k (. opts? k)))
           (keys opts?)))
    (map (fn [mode] (nvim.set_keymap mode from to options))
         (str->chars modes))
    (string.format "mapped :%s %s -> %s" modes from to)))

;; Fix cursor
(keymap :i :<C-c> "<cmd>NormalMode<CR>")
(keymap :i :<Esc> "<cmd>NormalMode<CR><cmd>noh<CR>i")
(keymap :v :<Esc> "<C-c>i")
;; Enforce insert mode
(keymap :n :<CR> "i<CR>")
(keymap :n :<Delete> "\"_d<right>i")
(keymap :n ")" "i)")
(keymap :n "(" "i(")
;; CUA mode
; Copy
(keymap :v :<C-c> "\"*y :let @+=@*<CR>")
(keymap :i :<C-S-c> "<cmd>NormalMode<CR>^vg_yi") ; copy line
(keymap :n :<C-S-c> "^vg_y")                     ; copy line
; Paste
(keymap :n :<C-v> "P<right>")
(keymap :i :<C-v> " <BS><cmd>NormalMode<CR>Pa")
(keymap :v :<C-v> "\"_dPi")
; Paste from clipboard into command line
(keymap :c :<C-v> "<C-R>+" {:noremap false :silent false})
(keymap :c :<S-Insert> "<C-R>+" {:noremap false :silent false})
; Cut
(keymap :v "<C-x>" "\"+x")
; Delete
(keymap :v :<Delete> "\"_d")
(keymap :v :<S-Delete> "\"_d")
(keymap :v :<Backspace> "\"_d")
;; Undo/redo
(keymap :n   :<C-z> "<cmd>undo<CR><right>")
(keymap :iv  :<C-z> "<cmd>undo<CR>")
(keymap :inv :<C-S-z> "<cmd>redo<CR>")
;; Kill the rest of the current line
(keymap :n :<C-k> "\"_D")
(keymap :i :<C-k> "<cmd>NormalMode<CR>\"_Di")
(keymap :c :<C-k> "<C-\\>e(strpart(getcmdline(), 0, getcmdpos() - 1))<CR>" {:silent false})
;; Duplicate line
(keymap :inv :<C-S-d> "<cmd>:t.<CR>")
; Comment
(keymap :in :<C-/> "<cmd>CommentToggle<CR>")
(keymap :v :<C-/> "<cmd>CommentToggleSelection<CR>")
;; Goto last edit
(keymap :n :<C-M-l> "g;")
(keymap :i :<C-M-l> "<C-c>g;i")
;; Center screen to cursor pos
(keymap :n :<C-l> "\"+zz")
(keymap :i :<C-l> "<C-c>\"+zzi")
;; Move viewport up & down
(keymap :n :<C-Up> "<C-y>")
(keymap :n :<C-Down> "<C-e>")
(keymap :i :<C-Up> "<cmd>NormalMode<CR><C-y>i")
(keymap :i :<C-Down> "<cmd>NormalMode<CR><C-e>i")
;; findWordAtCursor.previous
(keymap :n :<C-M-Up> "g#:let @/ = \"\"<CR>")
(keymap :v :<C-M-Up> "<C-C>g#:let @/ = \"\"<CR>v")
(keymap :i :<C-M-Up> "<C-C>g#:let @/ = \"\"<CR>i")
;; findWordAtCursor.next
(keymap :n :<C-M-Down> "g*:let @/ = \"\"<CR>")
(keymap :v :<C-M-Down> "<C-C>g*:let @/ = \"\"<CR>v")
(keymap :i :<C-M-Down> "<C-C>g*:let @/ = \"\"<CR>i")
;; Copy current buffer file path
(keymap :n :cp "<cmd>let @+=expand('%:p')<CR><cmd>echo @<CR>")
;; Open file
(keymap :n :<C-o> ":e " {:silent false})
(keymap :i :<C-o> "<C-c>:e " {:silent false})
;; Save
(keymap :inv :<C-s> "<cmd>:update<CR>")
;; Reload buffer file
(keymap :inv :<C-r> "<cmd>e<CR>")
;; Next/previous buffer
(keymap :inv :<C-PageUp> "<cmd>bp<CR>")
(keymap :inv :<C-PageDown> "<cmd>bn<CR>")
;; Close buffer
(keymap :inv :<C-w> "<cmd>bd<CR>")
;; Buffer switcher
(keymap :in :<F1> "<cmd>lua require('telescope.builtin').buffers()<CR>")
(keymap :in :<F2> "<cmd>lua require('telescope.builtin').treesitter()<CR>")
;; Search
(keymap :n :<C-f> "/" {:silent false})
(keymap :iv :<C-f> "<Esc>/" {:silent false})
(keymap :n :<C-S-f> "?" {:silent false})
(keymap :iv :<C-S-f> "<Esc>?" {:silent false})
(keymap :c :<Esc> "<cmd>CommandEsc<CR>")
(keymap :c :<CR> "<cmd>CommandRet<CR>")
(keymap :i :<C-n> "<C-c>nni")
(keymap :i :<C-S-n> "<C-c>Ni")
;; Jump to word/symbol
(keymap :in :<M-a> "<cmd>HopChar1<CR>")
;; Matchup
(keymap :i :<C-M-left> "<cmd>NormalMode<CR>%i")
(keymap :i :<C-M-right> "<cmd>NormalMode<CR>%a")
(keymap :i :<S-C-M-left> "<cmd>NormalMode<CR>v%")
(keymap :i :<S-C-M-right> "<cmd>NormalMode<CR>v%")
;; Version control
(keymap :inv :<M-w> "<cmd>NeogitCWD<CR><C-c>")
;; Cancel / Disable highlight
(keymap :in :<C-g> "<C-c><cmd>noh<CR>i")
(keymap :n :<Esc> "<Esc><cmd>noh<CR>")
;; Command
(keymap :inv :<M-x> "<Esc>:" {:silent false})
 ; Arrow key mappings for wildmenu tab completion
(vim.api.nvim_command "set wildcharm=<C-Z>")
(vim.api.nvim_command "cnoremap <expr> <up> wildmenumode() ? '<left>' : '<up>'")
(vim.api.nvim_command "cnoremap <expr> <down> wildmenumode() ? '<right>' : '<down>'")
(vim.api.nvim_command "cnoremap <expr> <left> wildmenumode() ? '<up>' : '<left>'")
(vim.api.nvim_command "cnoremap <expr> <right> wildmenumode() ? ' <bs><C-Z>' : '<right>'")
;; Windows split
(keymap :inv "<C-]>" "<cmd>:split<CR>")
(keymap :inv "<C-\\>" "<cmd>:vsplit<CR>")
(keymap :inv "<C-[>" "<cmd>:only<CR>")
;; Windmove
(keymap :inv "<M-Down>"  "<cmd>NormalMode<CR><C-w><Down><cmd>RestoreMode<CR>")
(keymap :inv "<M-Up>"    "<cmd>NormalMode<CR><C-w><Up><cmd>RestoreMode<CR>")
(keymap :inv "<M-Left>"  "<cmd>NormalMode<CR><C-w><Left><cmd>RestoreMode<CR>")
(keymap :inv "<M-Right>" "<cmd>NormalMode<CR><C-w><Right><cmd>RestoreMode<CR>")
;; Conjure
(keymap :invs "<C-e>" "<cmd>ConjureEvalCurrentForm<CR>")
(keymap :invs "<M-e>" "<cmd>ConjureEval<CR>")
(keymap :invs "<C-S-e>" "<cmd>ConjureEvalBuf<CR>")

