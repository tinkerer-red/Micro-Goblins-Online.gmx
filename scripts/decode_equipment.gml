///decode_equipment(encoded_array)

/*
This script will assign an array of 6 strings to the equipment slots,
each of which will contain a corrisponding equipment slot item's map which can be re encoded on another client

Returns: N/A

Input:
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

var array = argument0

if (array = last_encoded_equipment) {exit;}

//for all 3 equiped weapons
  //show_debug_message("about to try to decode")
  
  for (var i = 0; i < 3; i++){
  
    //check to see if this value has even changed
    //if the maps are different decode the map
    if (array[i] != last_encoded_equipment[i]) {
    
      var item_map = ds_map_create();
      
      //convert the encoded map back into a usable map
      ds_map_read(item_map, array[i])
      
      self.item_data[i, weapon_type] = item_map[? "weapon_type"]
      self.item_data[i, weapon_sprite] = item_map[? "weapon_sprite"]
      self.item_data[i, weapon_proj_sprite] = item_map[? "weapon_proj_sprite"]
      self.item_data[i, weapon_type] = item_map[? "weapon_type"]
      
      //destroy the left over map
      ds_map_destroy(item_map)
    }
    
    
    //if the item's priorities are not the same then decode them
    if (array[i+6] != last_encoded_equipment[i+6]) {
      
      var prior_str = array[i+6] //item_map[? "weapon_priorities"]
      
      //clone the priority queue, so we can extract the sub queues from the individual strings
      var temp_prior = ds_priority_create();
      ds_priority_read(temp_prior, prior_str)
      
      
      //extract the priority queues from the player
        var queue_button_mods = ds_priority_delete_min(item_queues[i])
        var queue_pre_weap_mods = ds_priority_delete_min(item_queues[i])
        var queue_weap_spawn_mods = ds_priority_delete_min(item_queues[i])
        var queue_proj_spawn_mods = ds_priority_delete_min(item_queues[i])
        var queue_attack_step_mods = ds_priority_delete_min(item_queues[i])
        var queue_pre_col_mods = ds_priority_delete_min(item_queues[i])
        var queue_col_mods = ds_priority_delete_min(item_queues[i])
        var queue_post_attack_mods = ds_priority_delete_min(item_queues[i])
        
      //convert the strings back into priority queues
      //AND over write the existing priority queues with these temp queues
        ds_priority_read(queue_button_mods, ds_priority_delete_min(temp_prior));
        ds_priority_read(queue_pre_weap_mods, ds_priority_delete_min(temp_prior));
        ds_priority_read(queue_weap_spawn_mods, ds_priority_delete_min(temp_prior));
        ds_priority_read(queue_proj_spawn_mods, ds_priority_delete_min(temp_prior));
        ds_priority_read(queue_attack_step_mods, ds_priority_delete_min(temp_prior));
        ds_priority_read(queue_pre_col_mods, ds_priority_delete_min(temp_prior));
        ds_priority_read(queue_col_mods, ds_priority_delete_min(temp_prior));
        ds_priority_read(queue_post_attack_mods, ds_priority_delete_min(temp_prior));
        
      //"put that queue back where it came from or so help me"
        ds_priority_add(item_queues[i], queue_button_mods, 1);
        ds_priority_add(item_queues[i], queue_pre_weap_mods, 2);
        ds_priority_add(item_queues[i], queue_weap_spawn_mods, 3);
        ds_priority_add(item_queues[i], queue_proj_spawn_mods, 4);
        ds_priority_add(item_queues[i], queue_attack_step_mods, 5);
        ds_priority_add(item_queues[i], queue_pre_col_mods, 6);
        ds_priority_add(item_queues[i], queue_col_mods, 7);
        ds_priority_add(item_queues[i], queue_post_attack_mods, 8);
      
      //clean up the cloned data
      ds_priority_destroy(temp_prior)
    }//end of if array != last encoded array
    
  }
  
  
  
  
  //Armor maps
  //down here we need to add in armor when it's finished although untill tehn we can probably ignore them with out causing any issues.
  for (var i = 0; i < 3; i++){
    //check to see if this value has even changed
    //if new value = old value, skip to the next item
    //if (array[i] = last_encoded_equipment[i]) { continue; }
  }
  
last_encoded_equipment = array
