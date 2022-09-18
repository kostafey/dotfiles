(module dotfiles.module.keybindings
  {require {nvim aniseed.nvim
            nu aniseed.nvim.util
            core aniseed.core}})

(defn- noremap [mode from to silent?]
  "Sets a mapping with {:noremap true}."
  (nvim.set_keymap mode from to {:noremap true
                                 :silent (or (when silent? true) 
                                             false)}))

;; CUA mode
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
(noremap :n :cd "<cmd>:t.<CR>")
; Comment
(noremap :i :<C-/> "<cmd>CommentToggle<CR>")
(noremap :n :<C-/> "<cmd>CommentToggle<CR>")
(noremap :c :<C-/> "<cmd>CommentToggle<CR>")
(noremap :v :<C-/> "<cmd>CommentToggleSelection<CR>")
;; Open file
(noremap :n :<C-o> ":e ")
(noremap :i :<C-o> "<C-c>:e ")
;; Save
(noremap :i :<C-s> "<cmd>:update<CR>")
(noremap :n :<C-s> "<cmd>:update<CR>")
(noremap :v :<C-s> "<cmd>:update<CR>")
;; Next/previous buffer
(noremap :n :<C-PageUp> ":bp<CR>")
(noremap :n :<C-PageDown> ":bn<CR>")
(noremap :i :<C-PageUp> "<C-c>:bp<CR>i")
(noremap :i :<C-PageDown> "<C-c>:bn<CR>i")
;; Close buffer
(noremap :n :<C-w> ":bd<CR>")
(noremap :i :<C-w> "<C-c>:bd<CR>i")
;; Buffer switcher
(noremap :n :<F1> "<cmd>lua require('telescope.builtin').buffers()<CR>")
(noremap :i :<F1> "<cmd>lua require('telescope.builtin').buffers()<CR>")
;; Search
(noremap :n :<C-f> "/")
(noremap :i :<C-f> "<Esc>/")
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

