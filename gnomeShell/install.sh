
SRC_GNOME_SHELL_SCRIPTS="/data/dotfiles/gnomeShell/"
DEST_GNOME_SHELL_SCRIPTS="/data/soft/bin/"

ln -sf "${SRC_GNOME_SHELL_SCRIPTS}chrome_window.sh" "${DEST_GNOME_SHELL_SCRIPTS}chrome_window.sh"
ln -sf "${SRC_GNOME_SHELL_SCRIPTS}emacs_window.sh" "${DEST_GNOME_SHELL_SCRIPTS}emacs_window.sh"
ln -sf "${SRC_GNOME_SHELL_SCRIPTS}firefox_window.sh" "${DEST_GNOME_SHELL_SCRIPTS}firefox_window.sh"
ln -sf "${SRC_GNOME_SHELL_SCRIPTS}list_windows.sh" "${DEST_GNOME_SHELL_SCRIPTS}list_windows.sh"
ln -sf "${SRC_GNOME_SHELL_SCRIPTS}mucommander_window.sh" "${DEST_GNOME_SHELL_SCRIPTS}mucommander_window.sh"
ln -sf "${SRC_GNOME_SHELL_SCRIPTS}terminal_window.sh" "${DEST_GNOME_SHELL_SCRIPTS}terminal_window.sh"
ln -sf "${SRC_GNOME_SHELL_SCRIPTS}vscode_window.sh" "${DEST_GNOME_SHELL_SCRIPTS}vscode_window.sh"
ln -sf "${SRC_GNOME_SHELL_SCRIPTS}vscode_maximize.sh" "${DEST_GNOME_SHELL_SCRIPTS}vscode_maximize.sh"
ln -sf "${SRC_GNOME_SHELL_SCRIPTS}deadbeef_window.sh" "${DEST_GNOME_SHELL_SCRIPTS}deadbeef_window.sh"
ln -sf "${SRC_GNOME_SHELL_SCRIPTS}jts_window.sh" "${DEST_GNOME_SHELL_SCRIPTS}jts_window.sh"

# Fix switch input language
# gsettings set org.gnome.desktop.wm.keybindings switch-input-source "['<Alt>Shift_L']"

# Better switch input language
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom7/ name "'switch-lang'"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom7/ binding "<Alt>Shift_L"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom7/ command "'/data/dotfiles/gnomeShell/switch-lang.sh'"

gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom8/ name "'switch-lang-caps'"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom8/ binding "<Alt>Caps_Lock"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom8/ command "'/data/dotfiles/gnomeShell/switch-lang.sh'"
