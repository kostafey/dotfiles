gdbus call \
  --session \
  --dest org.gnome.Shell \
  --object-path /org/gnome/Shell \
  --method org.gnome.Shell.Eval "      
    global              
      .get_window_actors()
      .map(a=>a.meta_window)                                   
      .map(w=>({class: w.get_wm_class(), title: w.get_title()}))" \
  | sed -E -e "s/^\(\S+, '//" -e "s/'\)$//" \
  | jq .