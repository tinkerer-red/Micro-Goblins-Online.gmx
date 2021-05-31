///scr_mod_summon_attack_charge()

if (object_index = obj_summon) || (object_index = obj_enemy){
  //init
  if !variable_instance_exists(self, "mod_summon_attack_charge_start"){
    summon_charge_mod_count = scr_queue_has_mod_count(step_event_queues_temp, scr_mod_summon_attack_charge)+1;
    //show_debug_message("attack mod_count = "+string(mod_count))
  
    e_damage += 0.5*summon_charge_mod_count
    
    mod_summon_attack_charge_start = true
    
    charge_active = false
    charge_anim_start = false
  }
  
  
  
  if (move_active = false){ //if we arew not restrained by movement mods
    
    //if we're in the correct event then activate
    if (mod_summon_attack_charge_start = true) {
      if (enemy != noone) && !attack_active{
        
        var charge_dist = one_chunk // 0.25 chunk size + (0.75 chunk size / (5-mod_count))  //this will give a max charge of 1 chunk, and a min charge of 6.4 tiles
        
        
        ///if the enemy is with in range
        if (point_distance(x, y, enemy.x, enemy.y) < charge_dist){
          
          //if the enemy is with in a cardinal direction
          var charge_dir = point_direction(x, y, enemy.x, enemy.y)
          var charge_dir_mod = charge_dir mod 90
          
          
          if (charge_dir_mod < 5) || (charge_dir_mod > 85){
            
            //init charge
            //round the charge direction off the a cardinal direction
            if (charge_dir <= 5)  || (charge_dir >= 355) {charge_dir = 0};   //right
            if (charge_dir > 85)  && (charge_dir < 95)   {charge_dir = 90};  //up
            if (charge_dir > 175) && (charge_dir < 185)  {charge_dir = 180}; //left
            if (charge_dir > 265) && (charge_dir < 275)  {charge_dir = 270}; //down
            
            if (attack_active = false)
            && ((angle_difference(direction, charge_dir) <= 45) || (spd = 0)){
              attack_active = true
              charge_anim_start = true
              direction = charge_dir
              charge_target_x = x+lengthdir_x(one_chunk*4, direction)
              charge_target_y = y+lengthdir_y(one_chunk*4, direction)
              
            }else{
              charge_target_x = undefined
              charge_target_y = undefined
            }
          }else{
            charge_target_x = undefined
            charge_target_y = undefined
          }
          
        }
      }
      
      //pause for a second to animate the attack
      if (attack_active = true){
        
        if (charge_active = false){ //if we are not actively chargeing
          if (charge_anim_start = true) { //if we're just starting the animation
            charge_anim_time = room_speed/7.5
            charge_anim_timer = 0
            charge_anim_start = false
          }
          
          //animate the summon
          if (charge_anim_timer < charge_anim_time){
            charge_anim_timer++
          }else{ //if the charge animation is finished
            charge_anim_timer = 0
            charge_active = true
          }
        
        
        }else{ //if we're actively chargeing
          //do the actual charge
          var charge_speed = one_chunk/room_speed //1 chunk per second speed
          var dir = point_direction(x, y, charge_target_x, charge_target_y);
          x += lengthdir_x(charge_speed*lag(), dir)
          y += lengthdir_y(charge_speed*lag(), dir)
          
          //check to see if we've collided with a solid object
          if !place_free(x, y) || chunk_tile_meeting_precise(x, y){
            var collided_with_solid = true
          }else{
            var collided_with_solid = false
          }
          
          //if we have reached our final location
          //land regardless of collision
          if (point_distance(x, y, charge_target_x, charge_target_y) < charge_speed*lag()+1)
          || (collided_with_solid){
            attack_active = false
            charge_active = false
          }
        }
        
        if place_meeting(x, y, enemy) {
          deal_damage(enemy, e_damage)
        }
      } //end attack_active
    } //end of charge start
  } //end of if move active
}

return false;



