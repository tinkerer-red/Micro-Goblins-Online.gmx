///scr_mod_tractorBeam
//
//global
//proj spawn modifier

//show_debug_message("scr_mod_tractorBeam")

if (object_index = obj_weapon){
  //show_debug_message("made it inside the effects!")
  
  var mod_count = scr_queue_has_mod_count(active_queue, scr_mod_tractorBeam)
  
  
  
  //init
  if !variable_instance_exists(self, "mod_tractorBeam_start"){
    mod_tractorBeam_start = true;
    mod_tractorBeam_move_speed = 5.6888 //The entity will move at this speed only if it is with in 5.6888 distance from the weapon
    mod_tractorBeam_timer = room_speed + (room_speed*0.5)*(mod_count-1)
    
    //draw target code
    mod_tractorBeam_target_x = x+lengthdir_x(w_hype, direction)
    mod_tractorBeam_target_y = y+lengthdir_y(w_hype, direction)
    mod_tractorBeam_target_max_dist = one_chunk + ((one_chunk*0.5)*mod_count)
    mod_tractorBeam_target_max_pull_dist = one_chunk + ((one_chunk*0.5)*6)
    
    mod_tractorBeam_extra_time = -(room_speed/2)
    
    //get the over all list
    mod_tractorBeam_list = collision_cone_list(owner_id.x, owner_id.y, direction, mod_tractorBeam_target_max_dist, 11.25, obj_entity, false, true)
    
    //remove everything which isn't an enemy
    cull_list_for_enemies(mod_tractorBeam_list)
    
    //if the list is empty might as well return true
    if (ds_list_size(mod_tractorBeam_list) = 0){
      return true;
    }
  }
  
  
  
  
  if (mod_count = 1){
    
    //if the button isn't being pressed just use the normal timer
    if (!(owner_id.item_a || owner_id.item_b || owner_id.item_c)
    && (mod_tractorBeam_timer > 0))
    //if the button is being pressed give it an additional half second to pull
    || ((owner_id.item_a || owner_id.item_b || owner_id.item_c)
    && (mod_tractorBeam_timer > mod_tractorBeam_extra_time)){
      
      if (mod_tractorBeam_start = true){
        
        //decrement the timer
        mod_tractorBeam_timer -= 1*lag()
        show_debug_player(0, "mod_tractorBeam_timer = "+string(mod_tractorBeam_timer))
        
        
        //for each enemy find ideal new location
        for (var i = ds_list_size(mod_tractorBeam_list)-1; i >= 0; i--){
          var enemy = mod_tractorBeam_list[| i]
          
          //direction
          var dir = point_direction(enemy.x, enemy.y, mod_tractorBeam_target_x, mod_tractorBeam_target_y)
          
          //distance
          var percent_distance = (mod_tractorBeam_target_max_dist-point_distance(enemy.x, enemy.y, mod_tractorBeam_target_x, mod_tractorBeam_target_y)) / mod_tractorBeam_target_max_pull_dist
          var dist = min( (mod_tractorBeam_move_speed*percent_distance)*lag(), point_distance(enemy.x, enemy.y, mod_tractorBeam_target_x, mod_tractorBeam_target_y)*lag() )
          
          //location
          var ideal_x = enemy.x+lengthdir_x(dist, dir)
          var ideal_y = enemy.y+lengthdir_y(dist, dir)
          
          //need to use with statement for proper collision checking
          with (enemy){
            if (place_free(ideal_x, ideal_y) && !chunk_tile_meeting_precise(ideal_x, ideal_y)){
              x = ideal_x
              y = ideal_y
            }
            else
            {
              //use the recursive checks to find a better location
              move_towards(ideal_x, ideal_y, dist)
            }
          }
        }
        
        
        
        
        //move the target into the direction the player is currently pressing
        if not ((!ceil(owner_id.right) && !ceil(owner_id.left) && !ceil(owner_id.down) && !ceil(owner_id.up)) || 
        (owner_id.right == owner_id.left && owner_id.up == owner_id.down)){
          
          mod_tractorBeam_target_x += (owner_id.right - owner_id.left) * mod_tractorBeam_move_speed *lag()
          mod_tractorBeam_target_y += (owner_id.down - owner_id.up) * mod_tractorBeam_move_speed *lag()
          
          //pull it back inside the radius
          if (point_distance(mod_tractorBeam_target_x, mod_tractorBeam_target_y, owner_id.x, owner_id.y) > mod_tractorBeam_target_max_dist){
            var target_dir = point_direction(owner_id.x, owner_id.y, mod_tractorBeam_target_x, mod_tractorBeam_target_y)
            mod_tractorBeam_target_x = owner_id.x+lengthdir_x(mod_tractorBeam_target_max_dist, target_dir)
            mod_tractorBeam_target_y = owner_id.y+lengthdir_y(mod_tractorBeam_target_max_dist, target_dir)
            
          }
        }
      }
      
    }else{ //when the timer is finished
      
      
      //destroy the list
      ds_list_destroy(mod_tractorBeam_list)
      return true
    }
    
    
  }else{
    //show_debug_message("target returned true 2")
    return true;
  }
}
