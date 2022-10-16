(local nvim (require :aniseed.nvim))

(local {: map
        : keys
        : str->chars} (require :lib.core))

(fn command [name impl-fn args-count]
  "Define new command."
  (vim.api.nvim_create_user_command 
    name impl-fn {:nargs args-count}))

(fn get-mode []
  (. (vim.api.nvim_get_mode) :mode))

(fn restore-mode [mode]
  (match mode
    "i" (vim.cmd "startinsert")
    "n" (vim.cmd "stopinsert")))

(fn visual-mode? []
  (= (get-mode) "v"))

(fn normal-mode? []
  (= (get-mode) "n"))

(fn insert-mode? []
  (= (get-mode) "i"))

(fn feed-keys [keys mode?]
  (vim.api.nvim_feedkeys keys (or mode? (get-mode)) true))

(fn next-char [] (feed-keys "l"))
(fn prew-char [] (feed-keys "h"))

(fn normal-mode []
  ; (save-mode)
  (let [mode (get-mode)
        [y x] (vim.api.nvim_win_get_cursor 0)]
    (vim.cmd "stopinsert")
    (when (and (or (= mode "i") (= mode "R")) (> x 0))
      (next-char))))
 
(fn insert-mode []
  ; (save-mode)
  (vim.cmd "startinsert"))

(fn keymap [modes from to opts?]
  "Set keybindings."
  (let [options {:noremap true :silent true}]
    (when opts?
      (map (fn [k] (tset options k (. opts? k)))
           (keys opts?)))
    (map (fn [mode] (nvim.set_keymap mode from to options))
         (str->chars modes))
    (string.format "mapped :%s %s -> %s" modes from to)))

(fn cursor []
  "Get cursor position [y x]."
  (vim.api.nvim_win_get_cursor 0))

(fn line []
  "Get cursor current line text."
  (let [[y x] (cursor)]
    (. (vim.api.nvim_buf_get_lines 0 (- y 1) y true) 1)))

(fn get-lines [start end]
  "Gets a line-range from the buffer."
  (vim.api.nvim_buf_get_lines 0 start end true))

(fn set-lines [start end replacement]
  "Sets (replaces) a line-range in the buffer."
  (vim.api.nvim_buf_set_lines 0 start end true replacement))

(fn kill-rest-of-line []
  "Kill the rest of the current line."
  (let [[y x] (cursor)
        line-text (line)]
    (if (< x (length (line)))
      (set-lines (- y 1) y [(string.sub line-text 0 x)])
      (set-lines (- y 1) (+ y 1) 
                     [(. (get-lines (- y 1) (+ y 1)) 2)]))))

(fn kill-line []
  "Kill current line."
  (vim.api.nvim_del_current_line))

(command "KillRestOfLine" kill-rest-of-line 0)
(command "KillLine" kill-line 0)

{: command
 : get-mode
 : visual-mode?
 : normal-mode?
 : feed-keys
 : keymap
 : cursor
 : line
 : insert-mode
 : normal-mode
 : get-lines
 : set-lines
 : kill-rest-of-line
 : kill-line}
