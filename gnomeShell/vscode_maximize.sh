code "$@" &&
gdbus call \
  --session \
  --dest org.gnome.Shell \
  --object-path /org/gnome/Shell \
  --method org.gnome.Shell.Eval "
var mw =
  global.get_window_actors()
    .map(w=>w.meta_window)
    .filter(mw=>mw.get_wm_class().includes('Code'))
    .map(mw=>mw.maximize(Meta.MaximizeFlags.HORIZONTAL | Meta.MaximizeFlags.VERTICAL));
if (mw) {
  mw.maximize(Meta.MaximizeFlags.HORIZONTAL | Meta.MaximizeFlags.VERTICAL);
} else {
  imports.misc.util.spawnCommandLine('code')
}"