(module cua-mode
  {require {nvim aniseed.nvim
            nu aniseed.nvim.util
            core aniseed.core}})

(local {: command
        : nvim-command
        : get-mode
        : mode-name
        : feed-keys
        : replace-termcodes
        : insert-mode
        : normal-mode} (require :lib.api))

;; insert-mode on startup
(insert-mode)

(var current-mode "n")

(fn save-mode []
  (set current-mode (get-mode)))

(fn restore-mode []
  (match current-mode
    "i" (vim.cmd "startinsert")
    "n" (vim.cmd "stopinsert")))

(fn command-ret []
  (feed-keys "\n")
  (insert-mode))

(fn command-esc []
  (let [cmd-type (vim.api.nvim_eval "getcmdtype()")]
    (if (or (= cmd-type "/") (= cmd-type "?"))
      (command-ret)
      (do
        (vim.api.nvim_eval "setcmdline(\"\")")
        (command-ret)))))

(fn word-forward []
  (nvim-command "set iskeyword-=.") ; Add dot as word separator
  (let [esc (replace-termcodes "<Esc>")
        C-c (replace-termcodes "<C-c>")]
    (match (mode-name (get-mode))
      :insert (do 
                (normal-mode)
                (feed-keys "ea" "n"))
      :visual (feed-keys "vea" "n")
      :normal (feed-keys "ea" "n")
      :select (do
                (feed-keys esc "s")
                (feed-keys C-c "n")
                (feed-keys "ea" "n")))))

(fn word-forward-select []
  (nvim-command "set iskeyword-=.") ; Add dot as word separator
  (let [C-g (replace-termcodes "<C-g>")]
    (match (mode-name (get-mode))
    :insert (do
              (normal-mode)
              (feed-keys "ve" "n")
              (feed-keys C-g "v"))
    :visual (do 
              (feed-keys "e" "n")
              (feed-keys C-g "v"))
    :normal (do 
              (feed-keys "ve" "n")
              (feed-keys C-g "v"))
    :select (do
              (feed-keys C-g "s")
              (feed-keys "e" "n")
              (feed-keys C-g "v")))))

(fn word-backward []
  (nvim-command "set iskeyword-=.") ; Add dot as word separator
  (let [esc (replace-termcodes "<Esc>")
        C-c (replace-termcodes "<C-c>")]
    (match (mode-name (get-mode))
      :insert (do 
                (normal-mode)
                (feed-keys "bi" "n"))
      :visual (feed-keys "vbi" "n")
      :normal (feed-keys "bi" "n")
      :select (do
                (feed-keys esc "s")
                (feed-keys C-c "n")
                (feed-keys "bi" "n")))))

(fn word-backward-select []
  (nvim-command "set iskeyword-=.") ; Add dot as word separator
  (let [C-g (replace-termcodes "<C-g>")]
    (match (mode-name (get-mode))
    :insert (do
              (normal-mode)
              (feed-keys "vb" "n")
              (feed-keys C-g "v"))
    :visual (do 
              (feed-keys "b" "n")
              (feed-keys C-g "v"))
    :normal (do 
              (feed-keys "vb" "n")
              (feed-keys C-g "v"))
    :select (do
              (feed-keys C-g "s")
              (feed-keys "b" "n")
              (feed-keys C-g "v")))))

(command "SaveMode" save-mode 0)
(command "RestoreMode" restore-mode 0)
(command "NormalMode" normal-mode 0)
(command "InsertMode" insert-mode 0)
(command "CommandRet" command-ret 0)
(command "CommandEsc" command-esc 0)

(command "WordForward" word-forward 0)
(command "WordForwardSelect" word-forward-select 0)
(command "WordBackward" word-backward 0)
(command "WordBackwardSelect" word-backward-select 0)

