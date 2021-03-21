///scr_mod_summon_movement_default()


///scr_mod_summon_movement_default()
//
//summon step event

if (object_index = obj_summon) || (object_index = obj_enemy){
    
    
    //init
    if !variable_instance_exists(self, "mod_summon_movement_default_start"){
      if (enemy != noone){
        mp_xgoal    = enemy.x  //The target x position.
        mp_ygoal    = enemy.y  //The target y position.
      }else{
        mp_xgoal    = x  //The target x position.
        mp_ygoal    = y  //The target y position.
      }
      
      dir = point_direction(x, y, mp_xgoal, mp_ygoal )
      spd = 0
      mod_summon_movement_default_mod_count = scr_queue_has_mod_count(step_event_queues, scr_mod_summon_movement_default)
      max_step_size = mod_summon_movement_default_mod_count * 0.75 * (60/room_speed) //1 = 0.75, 5 = 3.75
      wander_min = 16*8
      wander_max = 16*12
      
      mod_summon_movement_default_start = true
    }
    
    
//    var mod_count = scr_queue_has_mod_count(step_event_queues_temp, scr_mod_summon_movement_default)+1
    
    if (attack_active = false){ //if we arew not restrained by attack mods
      if (mod_summon_movement_default_start = true){
        
        if (enemy != noone){
          if instance_exists(enemy){
            // move to enemy
            var goal_direction = point_direction(x, y, enemy.x, enemy.y)
            dir = goal_direction
          }
        }else{
  //          //wander
  //          var vector = mean_vectors(spd, dir, max_step_size, dir+htme_random_range(-2, 2))
  //          spd = vector[0]
  //          dir = vector[1]
  //          var start_dist = point_distance(x, y, start_x, start_y)
  //          if (start_dist > wander_min){
  //            var start_dir = point_direction(x, y, start_x, start_y)
  //            var normalized_speed = normalize(start_dist, wander_min, wander_max)
  //            var vector = mean_vectors(spd, dir, normalized_speed*max_step_size, start_dir)
  //            spd = vector[0]
  //            dir = vector[1]
  //          }
        }
          
          //avoid non-enemy entities 
          var near_obj = instance_nearest_notme(x, y, obj_entity)
          if (near_obj = self){show_debug_player(0, "self is near_obj")}
          
          //if the nearest obj isnt the enemy move slightly away from it
          if (near_obj != enemy){
            var near_obj_dist = point_distance(near_obj.x, near_obj.y, x, y)
            if (near_obj_dist < sprite_width){
              var normalized_speed = 1-normalize(near_obj_dist, 0, sprite_width)
              var inverse_entity_direction = point_direction(near_obj.x, near_obj.y, x, y)
              var vector = add_vectors(1, dir, 1.5, inverse_entity_direction)
              //spd = vector[0]
              dir = vector[1]
            }
          }else{
          //if the nearest obj is the player, circle around it.
            var near_obj_dist = point_distance(near_obj.x, near_obj.y, x, y)
            if (near_obj_dist < sprite_width){
              var a_diff = angle_difference(dir, direction)
              var normalized_dist = 1-normalize(near_obj_dist, 0, sprite_width)
              var _sign = sign(a_diff);
              dir += _sign*(180*normalized_dist)
            }
          }
          
          
          //avoid walls
  //        var tile_direction = tile_collision_normal(x, y, max_step_size*1.4, 2, false)
  //        if (tile_direction != -1){
  //          var vector = mean_vectors(spd, dir, max_step_size, tile_direction)
  //          spd = vector[0]
  //          dir = vector[1]
  //        }
          
          //actually apply the movement
          direction = mean(dir, direction) //move half the direction change
          speed = mean(max_step_size, speed, speed, speed) //only increase 1/4 the speed
          
          x += lengthdir_x(max_step_size, direction)
          y += lengthdir_y(max_step_size, direction)
          
          speed = 0
          
          
          ///only update once every 3 seconds
          if (update_enemy_time >= room_speed*3){
            enemy = nearest_enemy(x, y, 16*50)
            update_enemy_time = 0
          }else{
            update_enemy_time += 1*lag()
          }
        }
      }
    }

return false;



