///scr_mod_summon_attack_leap()

if (object_index = obj_summon) || (object_index = obj_enemy){
  //init
  if !variable_instance_exists(self, "mod_summon_attack_leap_start"){
    summon_leap_mod_count = scr_queue_has_mod_count(step_event_queues_temp, scr_mod_summon_attack_leap)+1;
    //show_debug_message("attack mod_count = "+string(mod_count))
  
    e_damage += 0.5*summon_leap_mod_count
    
    mod_summon_attack_leap_start = true
    
    leap_active = false
    leap_anim_start = false
  }
  
  
  
  if (move_active = false){ //if we arew not restrained by movement mods
    
    //if we're in the correct event then activate
    if (mod_summon_attack_leap_start = true) {
      
      //the player controlled attack code
      if (is_possessed){
        
        //find out if we're even pressing a direction before we activate the attack
        var _dist = clamp(point_distance(0, 0, possesser_id.right - possesser_id.left, possesser_id.down - possesser_id.up), 0, 1)
        
        if (attack_active = false)
        && (possesser_id.object_index = obj_player)
        && (possesser_id.item_b_pressed)
        && (_dist > 0.1){
          var leap_dist = 64 + (summon_leap_mod_count*38.4) // 0.25 chunk size + (0.75 chunk size / (5-mod_count))  //this will give a max leap of 1 chunk, and a min leap of 6.4 tiles
          
          var _dir = point_direction(0, 0, possesser_id.right - possesser_id.left, possesser_id.down - possesser_id.up)
          
          
          leap_target_x = x+lengthdir_x(_dist*leap_dist, _dir)
          leap_target_y = y+lengthdir_y(_dist*leap_dist, _dir)
          
          //help assist the player's attack by rounding to the nearest enemy if there is one in range
          var _enemy = nearest_enemy(leap_target_x, leap_target_y, one_tile*2)
          if (_enemy != noone) && (instance_exists(_enemy)){
            leap_target_x = _enemy.x
            leap_target_y = _enemy.y
          }
          
          attack_active = true
          leap_anim_start = true
          direction = _dir
        }
      
      
      }else{ //if not player controlled
        if (attack_active = false) {
          
          //the AI's natural attack code
          if (enemy != noone) && (instance_exists(enemy)){
            
            var leap_dist = 64 + (summon_leap_mod_count*38.4) // 0.25 chunk size + (0.75 chunk size / (5-mod_count))  //this will give a max leap of 1 chunk, and a min leap of 6.4 tiles
            
            ///if the enemy is close enough
            if (point_distance(x, y, enemy.x, enemy.y) < leap_dist){
              //init leap
              if (attack_active = false){
                leap_target_x = enemy.x
                leap_target_y = enemy.y
                
                attack_active = true
                leap_anim_start = true
                direction = point_direction(x, y, enemy.x, enemy.y)
              }
            }else{
              leap_target_x = x //undefined
              leap_target_y = y //undefined
            }
          }
        }
      }
      
      
      //pause for a second to animate the attack
      if (attack_active = true){
        
        if (leap_active = false){ //if we are not actively leaping
          if (leap_anim_start = true) { //if we're just starting the animation
            leap_anim_time = room_speed/summon_leap_mod_count
            
            //if thise is a player controlled leap, dont animate
            if (is_possessed) && (possesser_id.object_index = obj_player) && (possesser_id.item_b_pressed){
              leap_anim_time = 0
            }
            
            leap_anim_timer = 0
            leap_anim_start = false
          }
          
          //animate the summon
          if (leap_anim_timer < leap_anim_time){
            leap_anim_timer += 1*lag()
          }else{ //if the leap animation is finished
            leap_anim_timer = 0
            leap_active = true
          }
        
        
        }else{ //if we're actively leaping
          //do the actual leap
          var leap_speed = 256/room_speed //1 chunk per second speed
          var dir = point_direction(x, y, leap_target_x, leap_target_y);
          x += lengthdir_x(leap_speed*lag(), dir)
          y += lengthdir_y(leap_speed*lag(), dir)
          
          //if we have reached our final location
          //land regardless of collision
          if (point_distance(x, y, leap_target_x, leap_target_y) < leap_speed*lag()+1){
            attack_active = false
            leap_active = false
          }
        }
        
        if place_meeting(x, y, enemy) {
          deal_damage(enemy, e_damage)
        }
      } //end attack_active
    } //end of leap start
  } //end of if move active
}

return false;



