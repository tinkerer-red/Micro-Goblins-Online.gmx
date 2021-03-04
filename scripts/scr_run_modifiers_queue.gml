///scr_run_modifiers_queue(queue)

var returned = false

var _queue = argument0

if !ds_exists(active_queue_specific, ds_type_priority)
{
  if ds_exists(weapon_event_queues, ds_type_priority)
  {
    var step_queue = ds_priority_delete_min(weapon_event_queues) //the weapon queue will be in there even if nothing is in the queue its self
  
    active_queue_specific = ds_priority_create()
    ds_priority_copy(active_queue_specific, step_queue);
  }else{
    //show_debug_message("weapon_event_queues missing!!!")
    
  }
}

if !ds_priority_empty(active_queue_specific)
{
  //show_debug_message("Active queue !empty")
  while !ds_priority_empty(active_queue_specific)
  {
    //show_debug_message("Active queue STILL !empty")
    var scr = ds_priority_find_min(active_queue_specific);
    
    //show_debug_message("SCRIPT NAME = "+string(script_get_name(scr)))
    
    var delete = script_execute(scr)
    //in the scripts handle combos, conflictions, and return true when finished and ready to be deleted from queue
    
    if delete
    {
      //show_debug_message("DELETE = true")
      ds_priority_delete_min(active_queue_specific)
    } else {
      break;
    }
    
    if ds_priority_empty(active_queue_specific)
    {
      //show_debug_message("Active queue IS empty")
      returned =  true;
    }
  }

} else {  //if the list is empty 
  //show_debug_message("Active queue WAS ALWAYS empty")
  returned =  true;
}

if ds_exists(active_queue_specific, ds_type_priority)
{
  if ds_priority_empty(active_queue_specific)
  {
    ds_priority_destroy(active_queue_specific)
    active_queue_specific = -1
  }
}

if ds_exists(weapon_event_queues, ds_type_priority)
{
  if ds_priority_empty(weapon_event_queues)
  {
    //show_debug_message("weapon_event_queues is empty?")
    ds_priority_destroy(weapon_event_queues)
    weapon_event_queues = -1
  }
}

return returned;
