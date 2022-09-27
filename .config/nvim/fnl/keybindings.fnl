(module keybindings
  {require {nvim aniseed.nvim
            nu aniseed.nvim.util
            core aniseed.core}})

(defn- noremap [mode from to silent?]
  "Sets a mapping with {:noremap true}."
  (nvim.set_keymap mode from to {:noremap true
                                 :silent (or (when silent? true) 
                                             false)}))

(defn- keymap [mode from to opts?]
  (let [options (if opts?
                  opts?
                  {:noremap true})]
  (nvim.set_keymap mode from to options)))

;; CUA mode
; Copy
(noremap :n :<C-c> "\"*y :let @+=@*<CR>" :silent)
(noremap :v :<C-c> "\"*y :let @+=@*<CR>" :silent)
(noremap :i :<C-c> :<Esc> :silent) ; remap switch to normal mode
; Paste
(noremap :n :<C-v> "P<right>" :silent)
(noremap :i :<C-v> "<C-c>pa" :silent)
(noremap :v :<C-v> "\"_dPi" :silent)
; Paste from clipboard into command line
(keymap  :c :<C-v> "<C-R>+" {:noremap false})
(keymap  :c :<S-Insert> "<C-R>+" {:noremap false})
; Cut
(noremap :v "<C-x>" "\"+x" :noremap)
; Delete
(noremap :v :<Delete> "\"_d" :silent)
(noremap :n :<Delete> "\"_d<right>" :silent)
(noremap :v :<S-Delete> "\"_d" :silent)
(noremap :v :<Backspace> "\"_d" :silent)
;; Undo/redo
(noremap :n "<C-z>" ":undo<CR><right>" :silent)
(noremap :i "<C-z>" "<C-c>:undo<CR>a" :silent)
(noremap :v "<C-z>" "<C-c>:undo<CR>a" :silent)
(noremap :n "<C-S-z>" ":redo<CR>" :silent)
(noremap :i "<C-S-z>" "<C-c>:redo<CR>i" :silent)
(noremap :v "<C-S-z>" "<C-c>:redo<CR>i" :silent)
;; Kill the rest of the current line
(noremap :n :<C-k> "\"_D")
(noremap :i :<C-k> "<C-c><right>\"_Di")
;; Duplicate line
(noremap :i :<C-S-d> "<cmd>:t.<CR>")
(noremap :n :<C-S-d> "<cmd>:t.<CR>")
(noremap :n :cd "<cmd>:t.<CR>")
; Comment
(noremap :i :<C-/> "<cmd>CommentToggle<CR>")
(noremap :n :<C-/> "<cmd>CommentToggle<CR>")
(noremap :c :<C-/> "<cmd>CommentToggle<CR>")
(noremap :v :<C-/> "<cmd>CommentToggleSelection<CR>")
;; Goto last edit
(noremap :n :<C-M-l> "g;" :silent)
(noremap :i :<C-M-l> "<C-c>g;i" :silent)
;; Center screen to cursor pos
(noremap :n :<C-l> "\"+zz" :silent)
(noremap :i :<C-l> "<C-c>\"+zzi" :silent)
;; Move viewport up & down
(noremap :n :<C-Up> "<C-y>" :silent)
(noremap :n :<C-Down> "<C-e>" :silent)
(noremap :i :<C-Up> "<C-c>l<C-y>i" :silent)
(noremap :i :<C-Down> "<C-c>l<C-e>i" :silent)
;; findWordAtCursor.previous
(noremap :n :<C-M-Up> "g#:let @/ = \"\"<CR>")
(noremap :v :<C-M-Up> "<C-C>g#:let @/ = \"\"<CR>v")
(noremap :i :<C-M-Up> "<C-C>g#:let @/ = \"\"<CR>i")
;; findWordAtCursor.next
(noremap :n :<C-M-Down> "g*:let @/ = \"\"<CR>")
(noremap :v :<C-M-Down> "<C-C>g*:let @/ = \"\"<CR>v")
(noremap :i :<C-M-Down> "<C-C>g*:let @/ = \"\"<CR>i")
;; Copy current buffer file path
(noremap :n :cp "<cmd>let @+=expand('%:p')<CR><cmd>echo @<CR>")
(noremap :c :cp "<cmd>let @+=expand('%:p')<CR><cmd>echo @<CR>")
;; Open file
(noremap :n :<C-o> ":e ")
(noremap :i :<C-o> "<C-c>:e ")
;; Save
(noremap :i :<C-s> "<cmd>:update<CR>")
(noremap :n :<C-s> "<cmd>:update<CR>")
(noremap :v :<C-s> "<cmd>:update<CR>")
;; Reload buffer file
(noremap :n :<C-r> "<cmd>e<CR>" :silent)
(noremap :i :<C-r> "<cmd><C-c>e<CR>i" :silent)
;; Next/previous buffer
(noremap :n :<C-PageUp> ":bp<CR>")
(noremap :n :<C-PageDown> ":bn<CR>")
(noremap :i :<C-PageUp> "<C-c>:bp<CR>i")
(noremap :i :<C-PageDown> "<C-c>:bn<CR>i")
;; Close buffer
(noremap :n :<C-w> ":bd<CR>")
(noremap :i :<C-w> "<C-c>:bd<CR>i")
(noremap :v :<C-w> "<C-c>:bd<CR>i")
;; Buffer switcher
(noremap :n :<F1> "<cmd>lua require('telescope.builtin').buffers()<CR>")
(noremap :i :<F1> "<cmd>lua require('telescope.builtin').buffers()<CR>")
(noremap :n :<F2> "<cmd>lua require('telescope.builtin').treesitter()<CR>")
(noremap :i :<F2> "<cmd>lua require('telescope.builtin').treesitter()<CR>")
;; Search
(noremap :n :<C-f> "/")
(noremap :i :<C-f> "<Esc>/")
(noremap :c :<Esc> "<C-c>")
;; Jump to word/symbol
(noremap :n :<M-a> "<cmd>HopChar1<CR>")
(noremap :i :<M-a> "<cmd>HopChar1<CR>")
;; Version control
(noremap :n :<M-w> "<cmd>:NeogitCWD<CR>")
(noremap :i :<M-w> "<C-c><cmd>:NeogitCWD<CR>")
;; Cancel / Disable highlight
(noremap :n :<C-g> "<Esc><cmd>noh<CR>")
(noremap :i :<C-g> "<Esc><cmd>noh<CR>")
(noremap :n :<Esc> "<Esc><cmd>noh<CR>")
(noremap :i :<Esc> "<Esc><cmd>noh<CR>")
;; Command
(noremap :i :<M-x> "<Esc>:")
(noremap :n :<M-x> ":")
 ; Arrow key mappings for wildmenu tab completion
(vim.api.nvim_command "set wildcharm=<C-Z>")
(vim.api.nvim_command "cnoremap <expr> <up> wildmenumode() ? '<left>' : '<up>'")
(vim.api.nvim_command "cnoremap <expr> <down> wildmenumode() ? '<right>' : '<down>'")
(vim.api.nvim_command "cnoremap <expr> <left> wildmenumode() ? '<up>' : '<left>'")
(vim.api.nvim_command "cnoremap <expr> <right> wildmenumode() ? ' <bs><C-Z>' : '<right>'")
;; Windows split
(noremap :n "<C-]>" "<cmd>:split<CR>")
(noremap :c "<C-]>" "<cmd>:split<CR>")
(noremap :v "<C-]>" "<cmd>:split<CR>")
(noremap :i "<C-]>" "<cmd>:split<CR>")
(noremap :n "<C-\\>" "<cmd>:vsplit<CR>")
(noremap :c "<C-\\>" "<cmd>:vsplit<CR>")
(noremap :v "<C-\\>" "<cmd>:vsplit<CR>")
(noremap :i "<C-\\>" "<cmd>:vsplit<CR>")
(noremap :n "<C-[>" "<cmd>:only<CR>")
(noremap :c "<C-[>" "<cmd>:only<CR>")
(noremap :i "<C-[>" "<cmd>:only<CR>")
;; Windmove
(noremap :i "<M-Down>" "<C-c><C-w><Down>i")
(noremap :n "<M-Down>" "<C-w><Down>")
(noremap :v "<M-Down>" "<C-w><Down>")
(noremap :i "<M-Up>" "<C-c><C-w><Up>i")
(noremap :n "<M-Up>" "<C-w><Up>")
(noremap :v "<M-Up>" "<C-w><Up>")
(noremap :i "<M-Left>" "<C-c><C-w><Left>i")
(noremap :n "<M-Left>" "<C-w><Left>")
(noremap :v "<M-Left>" "<C-w><Left>")
(noremap :i "<M-Right>" "<C-c><C-w><Right>i")
(noremap :n "<M-Right>" "<C-w><Right>")
(noremap :v "<M-Right>" "<C-w><Right>")

