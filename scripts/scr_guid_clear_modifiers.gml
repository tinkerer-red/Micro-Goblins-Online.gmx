///scr_guid_clear_modifiers([player_id])

if (argument_count = 1){
  var desired_player = argument[0]
  
  //make sure it's an instance, if not find the local player id owner
  if !instance_exists(desired_player){
    with obj_player{
      if (player_id_local = desired_player){
        var pid = id;
      }
    }
  }else{
    var pid = desired_player;
  }
  
}else{
  var desired_player = noone
}


if (desired_player = noone){
  with obj_player{
    if (player_id_local = 0){
      var pid = id;
    }
  }
}


for (var i = 0; i < 3; i++){  //for all three weapons
  var weapon_queue = pid.item_queues[i]
  var event_count = ds_priority_size(weapon_queue)
  //destroy all prior
  repeat (event_count){
    var event_queue = ds_priority_delete_min(weapon_queue)
    ds_priority_destroy(event_queue)
  }
  //create new priors
  for (var j = 0; j < event_count; j++){
    var event_queue = ds_priority_create()
    ds_priority_add(weapon_queue, event_queue, j)
  }
}
  
  
//debug console; lets go ahead and clear those values too
var size = ds_list_size(guid)

for (var i = 0; i < size; i++){
  var gui_item = guid[| i]
  
  if (gui_item[0] = "Random")
  || (gui_item[0] = "Random Mod Count")
  || (gui_item[0] = "Randomize Mods"){
    break;
  }
  
  //if slider
  if (gui_item[1] = 0){
    //if size is 0-5
    if (gui_item[3] = 0) && (gui_item[4] = 5){
      gui_item[2] = 0
    }
  }
}




