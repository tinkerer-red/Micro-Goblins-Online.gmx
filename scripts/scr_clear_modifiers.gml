/// scr_clear_modifiers()

var returned = false


if ds_exists(active_queue, ds_type_priority){
  ds_priority_destroy(active_queue)
  active_queue = -1
}


if ds_exists(weapon_event_queues, ds_type_priority){
//  while !(ds_priority_empty(weapon_event_queues)){
//    ds_priority_destroy(ds_priority_find_min(weapon_event_queues))
//  }
  ds_priority_destroy(weapon_event_queues)
  weapon_event_queues = -1
}

return returned;
