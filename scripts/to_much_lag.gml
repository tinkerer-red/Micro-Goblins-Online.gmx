///to_much_lag()



if (obj_lag_controller.to_much_lag_this_frame = true) return true;
if (1*lag() >= obj_lag_controller.skipped_steps){
  
  if (object_index = obj_weap_proj)
  || (object_index = obj_summon)
  || (object_index = obj_explode_particle)
  || (object_index = obj_dissolve_particle)
  || (object_index = obj_radial_particle)
  {
    if (ds_priority_find_priority(obj_lag_controller.laggy_objects_priority, object_index) == undefined){
      var count = instance_number(object_index)
      ds_priority_add(obj_lag_controller.laggy_objects_priority, object_index, count)
      //show_debug_message("added "+string(count)+" objects to priority")
    } 
  }
  
  obj_lag_controller.to_much_lag_this_frame = true
  return true;
}

return false;
