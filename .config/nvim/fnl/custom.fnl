(local {: find-file
        : command} (require :lib.api))

(fn open-config []
  "Open main configuration file."
  (find-file "~/.config/nvim/init.vim"))

(command "OpenConfig" open-config 0)
