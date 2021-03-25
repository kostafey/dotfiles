code $1 &&
gdbus call \
  --session \
  --dest org.gnome.Shell \
  --object-path /org/gnome/Shell \
  --method org.gnome.Shell.Eval "
var mw =
  global.get_window_actors()
    .map(w=>w.meta_window)
    .find(mw=>mw.get_wm_class().includes('Code'));
if (mw) {
  mw.maximize(Meta.MaximizeFlags.HORIZONTAL | Meta.MaximizeFlags.VERTICAL);
} else {
  imports.misc.util.spawnCommandLine('code')
}"