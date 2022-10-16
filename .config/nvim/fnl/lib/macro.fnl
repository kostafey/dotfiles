(fn qwe []
  `(let [qwe# "asd"]
    qwe#))

(fn with-normal-mode [body]
  (let [mode (get-mode)
        _ (when (insert-mode?)
            (normal-mode))
        result (body)]
    (print "mode")
    (print mode)
    ; (restore-mode mode)
    ; (vim.cmd "startinsert")
    (feed-keys "i")
    ; result
    ))

(fn save-excursion [body]
  `(let [buffer# (vim.api.nvim_win_get_buf 0)         
         pos# (vim.api.nvim_win_get_cursor 0)
         mode# (get-mode)
         result# ,body]
     (vim.api.nvim_win_set_buf 0 buffer#)
     (vim.api.nvim_win_set_cursor 0 pos#)
     result#))