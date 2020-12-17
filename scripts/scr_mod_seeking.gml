///scr_mod_seeking()
//
//projectile step event

//show_debug_message("scr_mod_seeking()")


//init
if !variable_instance_exists(self, "mod_seeking_start"){
  mod_seeking_start = true;
  
  
  //only define the nearest enemy once because the code is not very optimized
  var xx = x+lengthdir_x(speed*3, direction);
  var yy = y+lengthdir_y(speed*3, direction);
  nearest_obj = nearest_enemy(xx, yy, w_range*2);
}

mod_count = scr_queue_has_mod_count(step_event_queues_temp, scr_mod_seeking)

if (mod_seeking_start = true){
  mod_seeking_start = false
  if (object_index = obj_weap_proj){
    
    if (nearest_obj != noone){
      var seeking_angle_change = (180/room_speed)*(mod_count+1);
      
      var target_dir = point_direction(x, y, nearest_obj.x, nearest_obj.y);
      var angle_diff = angle_difference(direction, target_dir);
      
      if (abs(angle_diff) > seeking_angle_change){
        direction -= (sign(angle_diff) * seeking_angle_change)// * lag()
        image_angle = direction-45
      }else{
        direction -= angle_diff
        image_angle = direction-45
      }
    }
  }
}

//reload the modifier
//  this section is only here so we dont have to run the same mod 5 times but just
//  once with the same calculations and just multiply the result by 5.
if (mod_count = 0){
  mod_seeking_start = true;
}


return true
