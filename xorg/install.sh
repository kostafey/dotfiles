
SRC_XORG_SHELL_SCRIPTS="/data/dotfiles/xorg/"
DEST_GNOME_SHELL_SCRIPTS="/data/soft/bin/"

ln -sf "${SRC_XORG_SHELL_SCRIPTS}vscode_maximize.sh" "${DEST_GNOME_SHELL_SCRIPTS}vscode_maximize.sh"
ln -sf "${SRC_XORG_SHELL_SCRIPTS}vscode_window.sh" "${DEST_GNOME_SHELL_SCRIPTS}vscode_window.sh"
ln -sf "${SRC_XORG_SHELL_SCRIPTS}mucommander_window.sh" "${DEST_GNOME_SHELL_SCRIPTS}mucommander_window.sh"
ln -sf "${SRC_XORG_SHELL_SCRIPTS}terminal_window.sh" "${DEST_GNOME_SHELL_SCRIPTS}terminal_window.sh"
ln -sf "${SRC_XORG_SHELL_SCRIPTS}chrome_window.sh" "${DEST_GNOME_SHELL_SCRIPTS}chrome_window.sh"
ln -sf "${SRC_XORG_SHELL_SCRIPTS}deadbeef_window.sh" "${DEST_GNOME_SHELL_SCRIPTS}deadbeef_window.sh"
ln -sf "${SRC_XORG_SHELL_SCRIPTS}jts_window.sh" "${DEST_GNOME_SHELL_SCRIPTS}jts_window.sh"

# Fix switch input language
gsettings set org.gnome.desktop.input-sources sources "[('xkb', 'us'), ('xkb', 'ru')]"
setxkbmap us,ru -option "lv3:ralt_alt,grp:alt_caps_toggle"
