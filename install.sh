# Prerequisites:
# * git
# * feh

# Optional:
# * gnome-nettool
# * goldendict

# ------------------------------------------------------------
# mucommander
# sudo apt-get install wmctrl
ln -sf ~/dotfiles/.mucommander/action_keymap.xml ~/.mucommander/action_keymap.xml
ln -sf ~/dotfiles/.mucommander/commands.xml ~/.mucommander/commands.xml

sudo ln -sf ~/.emacs.d/launcher/current-winid /bin/current-winid
sudo ln -sf ~/.emacs.d/launcher/switch-to-emacsclient /bin/switch-to-emacsclient

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

# ------------------------------------------------------------
# lein
ln -sf ~/dotfiles/.lein/profiles.clj ~/.lein/profiles.clj

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
cp -R ~/dotfiles/.urxvt ~/

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

# ------------------------------------------------------------
# lein
ln -sf ~/dotfiles/.lein/profiles.clj ~/.lein/profiles.clj
