(local nvim (require :aniseed.nvim))

(local {: map
        : keys
        : str->chars} (require :lib.core))

(fn command [name impl-fn args-count]
  "Define new command."
  (vim.api.nvim_create_user_command 
    name impl-fn {:nargs args-count})
  (string.format "Defined command %s -> %s" name impl-fn))

(fn nvim-command [command]
  "Executes an Ex command."
  (vim.api.nvim_command command))

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

(fn mode-name [m]
  (. {:v :visual
      :s :select
      :n :normal
      :i :insert} m))

(fn feed-keys [keys mode?]
  (vim.api.nvim_feedkeys keys (or mode? (get-mode)) true))

(fn replace-termcodes [keys]
  "Replaces terminal codes and keycodes (<CR>, <Esc>, ...) 
in a string with the internal representation."
  (vim.api.nvim_replace_termcodes keys true true true))

(fn next-char [] (feed-keys "l"))
(fn prew-char [] (feed-keys "h"))

(fn normal-mode []
  "Return to normal mode from insert, keep cursor in place."
  (let [mode (get-mode)
        [y x] (vim.api.nvim_win_get_cursor 0)]
    (vim.cmd "stopinsert")
    (when (and (or (= mode "i") (= mode "R")) (> x 0))
      (next-char))))
 
(fn insert-mode []
  "Turn to insert from normal mode."
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

(fn get-cursor []
  "Get cursor position [y x]."
  (vim.api.nvim_win_get_cursor 0))

(fn set-cursor [y x]
  "Set cursor position [y x]."
  (vim.api.nvim_win_set_cursor 0 [y x]))

(fn exchange-point-and-mark []
  "Put the selection start where cursor is now, and cursor where
the selection start is now."
  (let [esc (replace-termcodes "<Esc><C-c>")
        gv (replace-termcodes "gv<C-g>")]
    (feed-keys esc "nx")
    (let [[_ y1 x1 _] (vim.fn.getpos "'<")
          [_ y2 x2 _] (vim.fn.getpos "'>")
          [y x] (get-cursor)]
      (if (or (< y1 y) (and (= y1 y) (< x1 x)))
        (do
          (vim.fn.setpos "'<" [0 y2 x2 0])
          (vim.fn.setpos "'>" [0 y1 x1 0]))
        (do
          (vim.fn.setpos "'>" [0 y2 x2 0])
          (vim.fn.setpos "'<" [0 y1 x1 0]))))
    (feed-keys gv "nx")))

(fn get-mark []
  "Get visual mark position [y x]."
  (let [[_ y x _] (vim.fn.getpos "v")]
    [y x]))

(fn set-mark [y x]
  "Get visual mark position [y x]."
  (vim.fn.setpos "." [0 y x 0]))

(fn get-selection-range []
  (let [esc (replace-termcodes "<Esc><C-c>")
        gv (replace-termcodes "gv<C-g>")]
    (feed-keys esc "nx")
    (let [[_ y1 x1 _] (vim.fn.getpos "'<")
          [_ y2 x2 _] (vim.fn.getpos "'>")]
      (feed-keys gv "nx")
      [y1 x1 y2 x2])))

(fn pprint [data]
  (match (type data)
    "table" (map pprint data)
    _ (print data)))

(fn line []
  "Get cursor current line text."
  (let [[y x] (get-cursor)]
    (. (vim.api.nvim_buf_get_lines 0 (- y 1) y true) 1)))

(fn get-lines [start end]
  "Gets a line-range from the buffer."
  (vim.api.nvim_buf_get_lines 0 start end true))

(fn set-lines [start end replacement]
  "Sets (replaces) a line-range in the buffer."
  (vim.api.nvim_buf_set_lines 0 start end true replacement))

(fn get-text [start_row start_col end_row end_col]
  "Gets a range from the buffer."
  (let [[start_row start_col end_row end_col]
        (if (<= start_col end_col)
          [start_row start_col end_row end_col]
          [end_row end_col start_row start_col])]
    (vim.api.nvim_buf_get_text 0 
      (- start_row 1) (- start_col 1) (- end_row 1) (- end_col 1) {})))

(fn set-text [start_row start_col end_row end_col replacement]
  "Sets (replaces) a range in the buffer."
  (vim.api.nvim_buf_set_text 0 
    (- start_row 1) (- start_col 1) 
    (- end_row 1) (- end_col 1) replacement))

(fn get-selection-text []
  (let [[y1 x1 y2 x2] (get-selection-range)]
    (get-text y1 x1 y2 x2)))

(fn wrap-text []
  (let [[y1 x1 y2 x2] (get-selection-range)
        text (get-text y1 x1 y2 x2)
        first 1
        last (length text)]
    (tset text first (.. "(" (. text first)))
    (tset text last (.. (. text last) ")"))
    (set-text y1 x1 y2 x2 text)))

(fn kill-rest-of-line []
  "Kill the rest of the current line."
  (let [[y x] (get-cursor)
        line-text (line)]
    (if (< x (length line-text))
      (set-lines (- y 1) y [(string.sub line-text 0 x)])
      (set-lines (- y 1) (+ y 1) 
                     [(. (get-lines (- y 1) (+ y 1)) 2)]))))

(fn kill-line []
  "Kill current line."
  (vim.api.nvim_del_current_line))

(fn find-file [file-path]
  "Edit file file-path.
Switch to a buffer visiting file file-path,
creating one if none already exists."
  (vim.cmd (string.format "e %s" file-path)))

(command "KillRestOfLine" kill-rest-of-line 0)
(command "KillLine" kill-line 0)
(command "WrapText" wrap-text 0)
(command "ExchangePointAndMark" exchange-point-and-mark 0)

{: command
 : nvim-command
 : get-mode
 : mode-name
 : visual-mode?
 : normal-mode?
 : feed-keys
 : replace-termcodes
 : keymap
 : get-cursor
 : set-cursor
 : line
 : insert-mode
 : normal-mode
 : get-lines
 : set-lines
 : kill-rest-of-line
 : kill-line
 : find-file}
