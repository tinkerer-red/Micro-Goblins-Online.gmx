///enough_lag()

if (obj_lag_controller.enough_lag_this_frame = true) return true;

if (get_timer() - obj_lag_controller._fps_time < 1000000/obj_lag_controller.ideal_fps*0.60){
  return false;
}else{
  obj_lag_controller.enough_lag_this_frame = true
  return true;
}



