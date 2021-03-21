///scr_run_modifiers

var returned = false


if !ds_exists(active_queue, ds_type_priority){
  if ds_exists(weapon_event_queues, ds_type_priority){
    var step_queue = ds_priority_delete_min(weapon_event_queues) //the weapon queue will be in there even if nothing is in the queue its self
  
    active_queue = ds_priority_create()
    ds_priority_copy(active_queue, step_queue);
  }else{
    //show_debug_message("weapon_event_queues missing!!!")
  }
}

if !ds_priority_empty(active_queue)
{
  while !ds_priority_empty(active_queue)
  {
    var scr = ds_priority_find_min(active_queue);
    var delete = script_execute(scr)
    
    if delete{
      ds_priority_delete_min(active_queue)
    } else {
      break;
    }
    
    if ds_priority_empty(active_queue){
      returned =  true;
    }
  }
} else {  //if the list is empty 
  returned =  true;
}

if ds_exists(active_queue, ds_type_priority){
  if ds_priority_empty(active_queue){
    ds_priority_destroy(active_queue)
    active_queue = -1
  }
}

if ds_exists(weapon_event_queues, ds_type_priority){
  if ds_priority_empty(weapon_event_queues){
    ds_priority_destroy(weapon_event_queues)
    weapon_event_queues = -1
  }
}

return returned;
