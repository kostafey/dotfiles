(ns activate
  (:require ["vscode" :as vscode]
            [my-lib] ; See this script for why we require it
            [promesa.core :as p]
            [joyride.core :as joyride]))

;; For more examples see:
;;   https://github.com/BetterThanTomorrow/joyride/tree/master/examples