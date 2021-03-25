gdbus call \
  --session \
  --dest org.gnome.Shell \
  --object-path /org/gnome/Shell \
  --method org.gnome.Shell.Eval "
var mw =
  global.get_window_actors()
    .map(w=>w.meta_window)
    .find(mw=>mw.get_title().includes('Chrome'));
if (mw) {
  mw.activate(0)
} else {
  imports.misc.util.spawnCommandLine('google-chrome')
}
"