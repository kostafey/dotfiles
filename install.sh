# Prerequisites:
# * git
# * feh

# Optional:
# * gnome-nettool
# * miredo
# * goldendict
# * udiskie
# * glances [gl] - system monitoring tool written in Python

# ------------------------------------------------------------
# mucommander
# sudo apt-get install wmctrl
ln -sf ~/dotfiles/.mucommander/action_keymap.xml ~/.mucommander/action_keymap.xml
ln -sf ~/dotfiles/.mucommander/commands.xml ~/.mucommander/commands.xml

# emacs
sudo ln -sf ~/.emacs.d/eframe-jack-in/linux/current-winid /bin/current-winid
sudo ln -sf ~/.emacs.d/eframe-jack-in/linux/switch-to-emacsclient /bin/switch-to-emacsclient
sudo chmod +x /bin/current-winid
sudo chmod +x /bin/switch-to-emacsclient

# vscode
ln -sf ~/dotfiles/.config/Code/User/keybindings.json ~/.config/Code/User/keybindings.json
ln -sf ~/dotfiles/.config/Code/User/settings.json ~/.config/Code/User/settings.json
ln -sf /data/dotfiles/.config/joyride/scripts ~/.config/joyride/scripts
ln -sf /data/dotfiles/.config/clj-kondo/config.edn ~/.config/clj-kondo/config.edn

# nvim
ln -sf /data/dotfiles/.config/nvim ~/.config/nvim

ln -sf ~/dotfiles/.vscode/extensions/organic-green ~/.vscode/extensions/organic-green

# intellij idea
ln -sf ~/dotfiles/.IdeaIC2017.2/config/keymaps/"Default for XWin copy.xml" \
   ~/.IdeaIC2017.2/config/keymaps/"Default for XWin copy.xml"

# alacritty
mkdir ~/.config/alacritty
ln -sf /data/dotfiles/.config/alacritty/alacritty.yml ~/.config/alacritty/alacritty.yml
ln -sf /data/dotfiles/.tmux.conf ~/.tmux.conf

# ------------------------------------------------------------
# sbcl
# sbcl --eval '(progn (ql:quickload :prove) (quit))'
ln -sf ~/dotfiles/.sbclrc ~/.sbclrc

# ------------------------------------------------------------
# stumpwm
ln -sf ~/dotfiles/.stumpwmrc ~/.stumpwmrc

mkdir -p ~/.stumpwm.d/modules/
cd ~/.stumpwm.d/modules/
git clone https://github.com/stumpwm/stumpwm-contrib.git

# ------------------------------------------------------------
# fonts
# cd ~/.fonts
# sudo mkfontscale
# sudo mkfontdir
# xset +fp ~/.fonts
# xset fp rehash
# fc-cache -fv
ln -sf ~/dotfiles/.fonts.conf ~/.fonts.conf

# ------------------------------------------------------------
# conky
# sudo apt-get install conky
# sudo apt-get install curl lm-sensors hddtemp
ln -sf ~/dotfiles/.conkyrc ~/.conkyrc

# ------------------------------------------------------------
# sbt
ln -sf ~/dotfiles/.sbt/0.13/global.sbt ~/.sbt/0.13/global.sbt
mkdir -p ~/.sbt/0.13/plugins
ln -sf ~/dotfiles/.sbt/0.13/plugins/plugins.sbt ~/.sbt/0.13/plugins/plugins.sbt

ln -sf ~/dotfiles/.sbt/1.0/global.sbt ~/.sbt/1.0/global.sbt
mkdir -p ~/.sbt/1.0/plugins
ln -sf ~/dotfiles/.sbt/1.0/plugins/plugins.sbt ~/.sbt/1.0/plugins/plugins.sbt

# ------------------------------------------------------------
# lein
ln -sf ~/dotfiles/.lein/profiles.clj ~/.lein/profiles.clj

# ------------------------------------------------------------
# maven
ln -sf ~/dotfiles/.m2/settings.xml ~/.m2/settings.xml

# ------------------------------------------------------------
# git
# sudo apt-get install git
# git config --global user.name "kostafey"
# git config --global user.email kostafey@gmail.com
ln -sf ~/dotfiles/.gitconfig ~/.gitconfig

# ------------------------------------------------------------
# urxvt
ln -sf ~/dotfiles/.Xresources ~/.Xresources
xrdb -merge ~/.Xresources
ln -sf ~/dotfiles/.urxvt ~/
ln -sf ~/dotfiles/.bashrc ~/.bashrc

# ------------------------------------------------------------
# java
# jdir=~/data/soft/java/jdk1.8.0_131/
# sudo update-alternatives --install /usr/bin/java java $jdir/bin/java 1
# sudo update-alternatives --install /usr/bin/javac javac $jdir/bin/javac 1
# sudo update-alternatives --install /usr/bin/javaws javaws $jdir/bin/javaws 1
# sudo update-alternatives --config java
# sudo update-alternatives --config javac
# sudo update-alternatives --config javaws

# ------------------------------------------------------------
# xkb

# ln -sf ~/dotfiles/.xkb ~/.xkb
ln -sf ~/dotfiles/.xxkbrc ~/.xxkbrc

function get_distro_name () {
    cat /etc/*-release | grep NAME | sed -n 2p | sed 's/"/\n/g' | sed -n 2p
}

# xsessionrc
if get_distro_name == "Debian GNU/Linux"
then
    ln -sf ~/dotfiles/.xsessionrc ~/.xsessionrc
fi
# ------------------------------------------------------------
# lein
ln -sf ~/dotfiles/.lein/profiles.clj ~/.lein/profiles.clj
