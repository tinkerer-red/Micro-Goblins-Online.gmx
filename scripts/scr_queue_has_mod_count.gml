///scr_queue_has_mod_count(queue_id, modifier_script_id)



var mod_count = 0
var queue_id = argument0
var modifier_script_id = argument1

if (ds_exists(queue_id, ds_type_priority)){
  ///duplicate the priority
  var temp_queue = ds_priority_create()
  ds_priority_copy(temp_queue, queue_id)
  /// then cycle through it
  while !ds_priority_empty(temp_queue){
    var mod_id = ds_priority_delete_min(temp_queue)
    // if found count up
    if (mod_id = modifier_script_id){
      mod_count += 1
    }
    
  }
  ds_priority_destroy(temp_queue)
}

return mod_count
