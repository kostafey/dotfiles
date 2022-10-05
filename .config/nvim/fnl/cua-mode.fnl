(module cua-mode
  {require {nvim aniseed.nvim
            nu aniseed.nvim.util
            core aniseed.core}})

(fn command [name impl-fn args-count]
  (vim.api.nvim_create_user_command 
    name impl-fn {:nargs args-count}))

(fn get-mode []
  (. (vim.api.nvim_get_mode) :mode))

(fn feed-keys [keys mode?]
  (vim.api.nvim_feedkeys keys (or mode? (get-mode)) true))

(fn next-char [] (feed-keys "l"))
(fn prew-char [] (feed-keys "h"))

(fn normal-mode []
  (let [mode (get-mode)
        [y x] (vim.api.nvim_win_get_cursor 0)]
    (vim.cmd "stopinsert")
    (when (and (or (= mode "i") (= mode "R")) (> x 0))
      (next-char))))
 
(fn insert-mode []
  (vim.cmd "startinsert"))

(macro save-excursion [body]
  `(let [buffer# (vim.api.nvim_win_get_buf 0)         
         pos# (vim.api.nvim_win_get_cursor 0)
         mode# (get-mode)
         result# ,body]
     (vim.api.nvim_win_set_buf 0 buffer#)
     (vim.api.nvim_win_set_cursor 0 pos#)
     result#))

(fn command-ret []
  (feed-keys "\ni"))

(fn command-esc []
  (let [cmd-type (vim.api.nvim_eval "getcmdtype()")]
    (if (or (= cmd-type "/") (= cmd-type "?"))
      (command-ret))
      (do
        (vim.api.nvim_eval "setcmdline(\"\")")
        (command-ret))))

(command "NormalMode" normal-mode 0)
(command "InsertMode" insert-mode 0)
(command "CommandRet" command-ret 0)
(command "CommandEsc" command-esc 0)

