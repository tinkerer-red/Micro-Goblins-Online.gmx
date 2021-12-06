if(
    (surface_get_width(application_surface) != floor(obj_camera_control.ww)) || (surface_get_height(application_surface) != floor(obj_camera_control.hh))
    || ((obj_camera_control.smooth_camera && ((surface_get_width(application_surface) != floor(display_get_gui_width()*obj_camera_control.upscale_val)) || (surface_get_height(application_surface) != floor(display_get_gui_height()*obj_camera_control.upscale_val))))
    || (!obj_camera_control.smooth_camera && ((surface_get_width(application_surface) != display_get_gui_width()) || (surface_get_height(application_surface) != display_get_gui_height()))))
  )
&& !window_minimized() {
  return true
}else{
  return false
}
