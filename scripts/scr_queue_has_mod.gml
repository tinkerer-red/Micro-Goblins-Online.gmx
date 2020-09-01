///scr_queue_has_mod(queue_id, modifier_script_id)



var returned = false
var queue_id = argument0
var modifier_script_id = argument1

if (ds_exists(queue_id, ds_type_priority)){
  if (ds_priority_find_priority(queue_id, modifier_script_id) != undefined){
    returned = true
  }
}

return returned
