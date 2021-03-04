///encode_equipment()

/*
This script will return an array of 6 strings,
each of which will contain a corrisponding equipment slot item's map which can be re encoded on another client

Returns: array
array[0] = item_a_map_str
array[1] = item_b_map_str
array[2] = item_c_map_str
array[3] = armor_head_map_str
array[4] = armor_body_map_str
array[5] = armor_boggle_map_str
array[6] = item_a_prior_str
array[7] = item_b_prior_str
array[8] = item_c_prior_str
array[9] = armor_head_prior_str
array[10] = armor_body_prior_str
array[11] = armor_boggle_prior_str
*/

var array;

//for all 3 equiped weapons
for (var i = 0; i < 3; i++){
  var item_map = ds_map_create();
  
  item_map[? "weapon_type"] = self.item_data[i, weapon_type]
  item_map[? "weapon_sprite"] = self.item_data[i, weapon_sprite]
  item_map[? "weapon_proj_sprite"] = self.item_data[i, weapon_proj_sprite]
  item_map[? "weapon_type"] = self.item_data[i, weapon_type]
  
  
  //clone the priority queue, so we can extract strings from the indevidual sub queues
  var temp_prior = ds_priority_create();
  ds_priority_copy(temp_prior, self.item_queues[i]);
  
    //string up each of the sub queues
    var queue_button_mods = ds_priority_write(ds_priority_delete_min(temp_prior));
    var queue_pre_weap_mods = ds_priority_write(ds_priority_delete_min(temp_prior));
    var queue_weap_spawn_mods = ds_priority_write(ds_priority_delete_min(temp_prior));
    var queue_proj_spawn_mods = ds_priority_write(ds_priority_delete_min(temp_prior));
    var queue_attack_step_mods = ds_priority_write(ds_priority_delete_min(temp_prior));
    var queue_pre_col_mods = ds_priority_write(ds_priority_delete_min(temp_prior));
    var queue_col_mods = ds_priority_write(ds_priority_delete_min(temp_prior));
    var queue_post_attack_mods = ds_priority_write(ds_priority_delete_min(temp_prior));
    
    //readd the strings to the temp priority queue
    ds_priority_add(temp_prior, queue_button_mods, 1);
    ds_priority_add(temp_prior, queue_pre_weap_mods, 2);
    ds_priority_add(temp_prior, queue_weap_spawn_mods, 3);
    ds_priority_add(temp_prior, queue_proj_spawn_mods, 4);
    ds_priority_add(temp_prior, queue_attack_step_mods, 5);
    ds_priority_add(temp_prior, queue_pre_col_mods, 6);
    ds_priority_add(temp_prior, queue_col_mods, 7);
    ds_priority_add(temp_prior, queue_post_attack_mods, 8);
    
  //now actually string up the over all weapon queue's priority
  var prior_str = ds_priority_write(temp_prior);
  
  //now finally add the priority to the encoded map
  //item_map[? "weapon_priorities"] = prior_str
  
  array[i+6] = prior_str
  
  //clean up the cloned data
  ds_priority_destroy(temp_prior)
  
  array[i] = ds_map_write(item_map)
  
  //destroy the left over map
  ds_map_destroy(item_map)
}





//down here we need to add in armor when it's finished although untill tehn we can probably ignore them with out causing any issues.
for (var i = 3; i < 6; i++){
  array[i] = ""
  //array[i+6] = ""
}

return array;

