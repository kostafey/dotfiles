(module cua-mode
  {require {nvim aniseed.nvim
            nu aniseed.nvim.util
            core aniseed.core}})

(defn command [name impl-fn args-count]
  (vim.api.nvim_create_user_command 
    name impl-fn {:nargs args-count}))

(defn get-mode []
  (. (vim.api.nvim_get_mode) :mode))

(defn normal-mode []
  (let [mode (get-mode)
        [y x] (vim.api.nvim_win_get_cursor 0)]
    (vim.cmd "stopinsert")
    (when (and (or (= mode "i") (= mode "R")) (> x 0))
      (vim.api.nvim_win_set_cursor 0 [y (+ x 1)]))))

(defn insert-mode [] 
  (vim.cmd "startinsert"))

(command "NormalMode" normal-mode 0)
(command "InsertMode" insert-mode 0)
