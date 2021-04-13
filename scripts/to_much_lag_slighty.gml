///to_much_lag_slighty()

if (obj_lag_controller.enough_lag_this_frame = true) return true;

if (1*lag() >= 2){

  obj_lag_controller.enough_lag_this_frame = true
  return true;
  
}

return false;
