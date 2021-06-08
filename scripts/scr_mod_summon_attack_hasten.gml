///scr_mod_summon_attack_hasten()

if (object_index = obj_summon) || (object_index = obj_enemy){
  //init
  if !variable_instance_exists(self, "mod_summon_attack_hasten_start"){
    summon_hasten_mod_count = scr_queue_has_mod_count(step_event_queues_temp, scr_mod_summon_attack_hasten)+1;
    //show_debug_message("attack mod_count = "+string(mod_count))
  
    e_damage += 0.5*summon_hasten_mod_count
    
    mod_summon_attack_hasten_start = true
    
    hasten_active = false
    hasten_anim_start = false
  }
  
  
  
  //if (attack_active){ //if we arew not restrained by movement mods
    
    //if we're in the correct event then activate
    if (mod_summon_attack_hasten_start = true) {
      if (enemy != noone){
        
        var hasten_dist = one_chunk//*0.25 + ((0.75*one_chunk) / (5-summon_hasten_mod_count))  //this will give a max hasten of 1 chunk, and a min hasten of 6.4 tiles
        
        
        ///if the enemy is with in range
        if instance_exists(enemy) && (point_distance(x, y, enemy.x, enemy.y) < hasten_dist){
          
          //if the enemy is with in a cardinal direction
          var hasten_dir = point_direction(x, y, enemy.x, enemy.y)
          var hasten_dir_mod = hasten_dir mod 90
          
          if ((hasten_dir_mod < 5)
          || (hasten_dir_mod > 85))
          || (is_possessed) {
            
            //normal AI attack
            if !is_possessed{
              //init hasten
              //round the hasten direction off the a cardinal direction
              if (hasten_dir <= 5)  || (hasten_dir >= 355) {hasten_dir = 0};   //right
              if (hasten_dir > 85)  && (hasten_dir < 95)   {hasten_dir = 90};  //up
              if (hasten_dir > 175) && (hasten_dir < 185)  {hasten_dir = 180}; //left
              if (hasten_dir > 265) && (hasten_dir < 275)  {hasten_dir = 270}; //down
            
            }else{//possessed attack
              var possessed_attack = possesser_id.item_b;
            }
            
            if (attack_active)
            && (((angle_difference(direction, hasten_dir) <= 45) || (spd = 0))
                || possessed_attack){
              
              attack_active = false
              hasten_anim_start = true
              
              if is_possessed{
                var possessed_vector_x = possesser_id.down - possesser_id.up;
                var possessed_vector_y = possesser_id.right - possesser_id.left;
                direction = point_direction(0, 0, possessed_vector_x, possessed_vector_y)
              }else{
                direction = hasten_dir
              }
              
              hasten_target_x = x+lengthdir_x(hasten_dist, direction)
              hasten_target_y = y+lengthdir_y(hasten_dist, direction)
              
            }else{
              hasten_target_x = undefined
              hasten_target_y = undefined
            }
          }else{
            hasten_target_x = x
            hasten_target_y = y
          }
          
        }
      }
      
      
      
      
      
      
      //pause for a second to animate the attack
      if (attack_active = false){
        
        if (hasten_active = false) { //if we are not actively hastening
          if (hasten_anim_start = true) { //if we're just starting the animation
            hasten_anim_time = room_speed/7.5
            hasten_anim_timer = 0
            hasten_anim_start = false
          }
          
          //animate the summon
          if (hasten_anim_timer < hasten_anim_time){
            hasten_anim_timer += 1*lag()
          }else{ //if the hasten animation is finished
            hasten_anim_timer = 0
            hasten_active = true
            invulnerable = true
          }
        
        
        }else{ //if we're actively hastening
          //do the actual hasten
          var hasten_speed = one_chunk/room_speed //1 chunk per second speed
          var dir = point_direction(x, y, hasten_target_x, hasten_target_y);
          x += lengthdir_x(hasten_speed*lag(), dir)
          y += lengthdir_y(hasten_speed*lag(), dir)
          
          //check to see if we've collided with a solid object
          if !place_free(x, y) || chunk_tile_meeting_precise(x, y){
            var collided_with_solid = true
          }else{
            var collided_with_solid = false
          }
          
          //if we have reached our final location
          //land regardless of collision
          if (point_distance(x, y, hasten_target_x, hasten_target_y) < hasten_speed*lag()+1)
          || (collided_with_solid){
            attack_active = true
            hasten_active = false
            invulnerable = false
          }
        }
        
        if place_meeting(x, y, enemy) {
          deal_damage(enemy, e_damage)
        }
        
        
        //handle the cooldown
        
        
//      } //end attack_active
    } //end of hasten start
  } //end of if move active
}

return false;



