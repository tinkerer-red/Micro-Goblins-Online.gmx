///to_much_lag()



if (obj_lag_controller.to_much_lag_this_frame = true) return true;
if (1*lag() >= obj_lag_controller.skipped_steps){
  
  if (object_index = obj_explode_particle)
  || (object_index = obj_dissolve_particle)
  || (object_index = obj_radial_particle)
  || (object_index = obj_summon)
  || (object_index = obj_weap_proj)
  {
    if (ds_priority_find_priority(obj_lag_controller.laggy_objects_priority, object_index) == undefined){
      
      var count = instance_number(object_index);
      var existing_count = ds_priority_find_priority(obj_lag_controller.laggy_objects_priority, object_index);
      
      //find out if it's already in the priority
      if (existing_count = undefined){
        
        //if it's not in the queue, then add it in to the queue
        ds_priority_add(obj_lag_controller.laggy_objects_priority, object_index, count)
        //show_debug_message("added "+string(count)+" objects to priority")
      
      }else{
        
        //if it's already in the queue, find out if count is larger then the current value
        if (existing_count > count){
          //if it is larger then over write the priority's value
          ds_priority_change_priority(obj_lag_controller.laggy_objects_priority, object_index, count)
        }
      
      }
      
    } 
  }
  
  obj_lag_controller.to_much_lag_this_frame = true
  return true;
}

return false;
