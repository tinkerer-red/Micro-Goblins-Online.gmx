///scr_run_modifiers

var returned = false


if !ds_exists(/*self.*/active_queue, ds_type_priority)
{
  //show_debug_message("Active queue !exist")
  if ds_exists(/*self.*/weapon_event_queues, ds_type_priority)
  {
    var /*self.*/step_queue = ds_priority_delete_min(/*self.*/weapon_event_queues) //the weapon queue will be in there even if nothing is in the queue its self
  
    /*self.*/active_queue = ds_priority_create()
    ds_priority_copy(/*self.*/active_queue, /*self.*/step_queue);
  }else{
    //show_debug_message("weapon_event_queues missing!!!")
    
  }
}

if !ds_priority_empty(/*self.*/active_queue)
{
  //show_debug_message("Active queue !empty")
  while !ds_priority_empty(/*self.*/active_queue)
  {
    //show_debug_message("Active queue STILL !empty")
    var /*self.*/scr = ds_priority_find_min(/*self.*/active_queue);
    
    //show_debug_message("SCRIPT NAME = "+string(script_get_name(/*self.*/scr)))
    
    var /*self.*/delete = script_execute(/*self.*/scr)
    //in the scripts handle combos, conflictions, and return true when finished and ready to be deleted from queue
    
    if /*self.*/delete
    {
      //show_debug_message("DELETE = true")
      ds_priority_delete_min(/*self.*/active_queue)
    } else {
      break;
    }
    
    if ds_priority_empty(/*self.*/active_queue)
    {
      //show_debug_message("Active queue IS empty")
      /*self.*/returned =  true;
    }
  }

} else {  //if the list is empty 
  //show_debug_message("Active queue WAS ALWAYS empty")
  /*self.*/returned =  true;
}

if ds_exists(active_queue, ds_type_priority)
{
  if ds_priority_empty(/*self.*/active_queue)
  {
    ds_priority_destroy(/*self.*/active_queue)
    /*self.*/active_queue = -1
  }
}

if ds_exists(weapon_event_queues, ds_type_priority)
{
  if ds_priority_empty(/*self.*/weapon_event_queues)
  {
    //show_debug_message("weapon_event_queues is empty?")
    ds_priority_destroy(/*self.*/weapon_event_queues)
    /*self.*/weapon_event_queues = -1
  }
}

return returned;
