///enough_lag()

if (obj_lag_controller.enough_lag_this_frame = true) return true;

if (get_timer() - obj_lag_controller._fps_time >= 100000/obj_lag_controller.ideal_fps){
  show_debug_player(0, "get_timer() - obj_lag_controller._fps_time = "+string(get_timer() - obj_lag_controller._fps_time))
  obj_lag_controller.enough_lag_this_frame = true
  return true;
}else{
  return false;
}



