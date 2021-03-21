///scr_mod_aimBot
//
//global
//pre attack modifier


var mod_count = scr_queue_has_mod_count(active_queue, scr_mod_aimBot)



if !variable_instance_exists(self, "mod_aimBot_start") || (mod_aimBot_start = false){
  mod_aimBot_start = true;
  var mod_aimBot_max_ang = (180/5)*mod_count
  
  
  var possible_enemies_list = collision_circle_list(x,y, 16*20*1.2, obj_entity, -1, true)
  //we add a little more then the player's reach just incase the enemy is walking towards the player, the projectile might end up meating up with them.
  
  //is there any entities in range
  if (possible_enemies_list != noone){
    
    //init the worst possible values
    var best_value = 9999999999
    var best_enemy = noone
    
    //for each enemy in the list
    for (var i = 0; i < ds_list_size(possible_enemies_list); i++){
      var entity = possible_enemies_list[| i]
      
      //is it even an enemy?
      if is_enemy(entity){
        //show_debug_message("found an enemy in the list")
        //find out how valuable each enemy is
        var e_ang_diff = angle_difference(direction, point_direction(x,y,entity.x,entity.y))
        
        //check to see if this is even with in our range of aimBot assistance
        if (abs(e_ang_diff) < mod_aimBot_max_ang){
          //show_debug_message("ints angle diff works too!"
          var dis = point_distance(x,y,entity.x,entity.y)
          var value = (abs(e_ang_diff))*(dis*2.2)
          //we prefer the distance over the angle difference but that doesnt mean the either is unimportant.
          
          if (value < best_value){
            //show_debug_message("it's even a best match")
            best_value = value
            best_enemy = entity
          }
        }
        
      } //end is_enemy
      
    } //end for
    
    ds_list_destroy(possible_enemies_list)
    
    //now finally make the change in direction
    direction -= e_ang_diff
  }
}


show_debug_message("mod_count = "+string(mod_count))
if (mod_count = 1){
  
  mod_aimBot_start = false
}



return true;
