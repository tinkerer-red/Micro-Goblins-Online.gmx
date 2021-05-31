///fullscreen_toggle(borderless)


var border = !argument0

is_true_fullscreened = window_get_fullscreen();

if (os_type = os_windows){
  is_borderless_fullscreened = window_frame_get_fullscreen();
}else{
  is_borderless_fullscreened = false;
}

if (is_borderless_fullscreened) || (is_true_fullscreened){
  if (is_borderless_fullscreened) {window_frame_set_fullscreen(false)};
  if (is_true_fullscreened) {
    window_set_fullscreen(false)
    //if we're fullscreened and we back out we need to re-enable the boarders for the frame
    if (os_type = os_windows){ window_frame_set_visible(true); }
  };
}else{
  if (border)  {window_frame_set_fullscreen(true)};
  if (!border) {window_set_fullscreen(true)};
}
