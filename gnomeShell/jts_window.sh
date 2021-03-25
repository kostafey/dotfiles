gdbus call \
  --session \
  --dest org.gnome.Shell \
  --object-path /org/gnome/Shell \
  --method org.gnome.Shell.Eval "
var mw =
  global.get_window_actors()
    .map(w=>w.meta_window)
    .find(mw=>mw.get_wm_class().includes('install4j-jclient-Launcher'));
if (mw) {
  mw.activate(0);
} else {
  imports.misc.util.spawnCommandLine('$HOME/Jts/tws')
}"