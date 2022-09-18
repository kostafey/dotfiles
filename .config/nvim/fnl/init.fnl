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
(noremap :v :<S-Delete> "\"_d" :silent)
(noremap :v :<Backspace> "\"_d" :silent)
;; Kill the rest of the current line
(noremap :n :<C-k> "\"_D")
(noremap :i :<C-k> "<C-c><right>\"_Di")
;; Duplicate line
(noremap :i :<C-S-d> "<cmd>:t.<CR>")
(noremap :n :cd "<cmd>:t.<CR>")
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
