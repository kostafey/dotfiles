(module cua-mode
  {require {nvim aniseed.nvim
            nu aniseed.nvim.util
            core aniseed.core}})

(local {: command
        : get-mode
        : feed-keys
        : visual-mode?
        : insert-mode
        : normal-mode} (require :lib.api))

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

(fn line-next []
  (normal-mode)
  (if (visual-mode?)
    (feed-keys "vj" "n")
    (feed-keys "j" "n")))

(fn char-forward []
  (normal-mode)
  (if (visual-mode?)
    (feed-keys "va" "n")
    (feed-keys "a" "n")))

(fn char-forward-select []
  (normal-mode)
  (if (visual-mode?)
    (feed-keys "l" "n")
    (feed-keys "vl" "n")))

(fn char-backward []
  (normal-mode)
  (if (visual-mode?)
    (feed-keys "vhi" "n")
    (feed-keys "hi" "n")))

(fn char-backward-select []
  (normal-mode)
  (if (visual-mode?)
    (feed-keys "h" "n")
    (feed-keys "vh" "n")))

(fn word-forward []
  (vim.api.nvim_command "set iskeyword-=.") ; Add dot as word separator
  (normal-mode)
  (if (visual-mode?)   
    (feed-keys "vea" "n")
    (feed-keys "ea" "n")))

(fn word-forward-select []
  (vim.api.nvim_command "set iskeyword-=.") ; Add dot as word separator
  (normal-mode)
  (if (visual-mode?)
    (feed-keys "e" "n")
    (feed-keys "ve" "n")))

(fn word-backward []
  (vim.api.nvim_command "set iskeyword-=.") ; Add dot as word separator
  (normal-mode)
  (if (visual-mode?)   
    (feed-keys "vbi" "n")
    (feed-keys "bi" "n")))

(fn word-backward-select []
  (vim.api.nvim_command "set iskeyword-=.") ; Add dot as word separator
  (normal-mode)
  (if (visual-mode?)
    (feed-keys "b" "n")
    (feed-keys "vb" "n")))

(fn line-beginning []
  (normal-mode)
  (if (visual-mode?)
    (feed-keys "v0i" "n")
    (feed-keys "0i" "n")))

(fn line-beginning-select []
  (normal-mode)
  (if (visual-mode?)
    (feed-keys "0" "n")
    (feed-keys "v0" "n")))

(fn line-end []
  (normal-mode)
  (if (visual-mode?)
    (feed-keys "v$li" "n")
    (feed-keys "$li" "n")))

(fn line-end-select []
  (normal-mode)
  (if (visual-mode?)
    (feed-keys "$l" "n")
    (feed-keys "v$l" "n")))

(command "RestoreMode" restore-mode 0)
(command "NormalMode" normal-mode 0)
(command "InsertMode" insert-mode 0)
(command "CommandRet" command-ret 0)
(command "CommandEsc" command-esc 0)

(command "WordForward" word-forward 0)
(command "WordForwardSelect" word-forward-select 0)
(command "WordBackward" word-backward 0)
(command "WordBackwardSelect" word-backward-select 0)

;; (command "CharForward" char-forward 0)
;; (command "CharForwardSelect" char-forward-select 0)
;; (command "CharBackward" char-backward 0)
;; (command "CharBackwardSelect" char-backward-select 0)
;; (command "LineNext" line-next 0)
;; (command "LineEnd" line-end 0)
;; (command "LineEndSelect" line-end-select 0)
;; (command "LineBeginning" line-beginning 0)
;; (command "LineBeginningSelect" line-beginning-select 0)
