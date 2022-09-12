(module dotfiles.module.keybindings
  {require {nvim aniseed.nvim
            nu aniseed.nvim.util
            core aniseed.core}})

(defn- noremap [mode from to]
  "Sets a mapping with {:noremap true}."
  (nvim.set_keymap mode from to {:noremap true}))

;; Next/previous buffer
(noremap :n :<C-PageUp> ":bp<CR>")
(noremap :n :<C-PageDown> ":bn<CR>")
(noremap :i :<C-PageUp> "<C-c>:bp<CR>i")
(noremap :i :<C-PageDown> "<C-c>:bn<CR>i")
;; Close buffer
(noremap :n :<C-w> ":bd<CR>")
(noremap :i :<C-w> "<C-c>:bd<CR>i")

;; Buffer switcher
(noremap :n :<F1> ":lua require('telescope.builtin').buffers()<CR>")
(noremap :i :<F1> "<C-c>:lua require('telescope.builtin').buffers()<CR>")
