#!/usr/bin/env bash

cur_idx=$(
        gdbus call \
                --session \
                --dest org.gnome.Shell \
                --object-path /org/gnome/Shell \
                --method org.gnome.Shell.Eval \
                "imports
                        .ui.status
                        .keyboard
                        .getInputSourceManager()
                        .currentSource
                        .index" |
        cut -d"'" -f2
)

next_idx=$(( 1 - $cur_idx ))

gdbus call \
        --session \
        --dest org.gnome.Shell \
        --object-path /org/gnome/Shell \
        --method org.gnome.Shell.Eval \
        "imports
                .ui
                .status
                .keyboard
                .getInputSourceManager()
                .inputSources[$next_idx]
                .activate()" \
        &> /dev/null
