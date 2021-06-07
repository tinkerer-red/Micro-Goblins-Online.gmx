///scr_mod_summon_movement_orbital()


///scr_mod_summon_movement_orbital()
//
//summon step event

if (object_index = obj_summon) || (object_index = obj_enemy){
    
    
    //init
    if !variable_instance_exists(self, "mod_summon_movement_orbital_start"){
      if is_summoned{
        dir = point_direction(owner_id.x, owner_id.y, x, y)
        cx = owner_id.x
        cy = owner_id.y
      }else{
        dir = 0
      }
      
      mod_summon_movement_orbital_mod_count = scr_queue_has_mod_count(step_event_queues, scr_mod_summon_movement_orbital)
      
      self.max_speed += 0.1*mod_summon_movement_orbital_mod_count
      
      pre_x = start_x
      pre_y = start_y
      
      orbital_dist = sprite_width*(mod_summon_movement_orbital_mod_count + is_summoned) *0.5
      orbital_rot  = direction
      max_step_size = 1
      
      mod_summon_movement_orbital_start = true
    }
    
    if (attack_active = false){ //if we arew not restrained by attack mods
      //for the first mod keep track of the center x and y
      if (mod_summon_movement_orbital_start = true){
        cx = x - lengthdir_x(orbital_dist, orbital_rot)
        cy = y - lengthdir_y(orbital_dist, orbital_rot)
        
        if (is_summoned)
        && !(variable_instance_exists(self, "is_mounted") && is_mounted && (mounted_id = owner_id)){ //is the owner isn't also mounting the AI
          cx = owner_id.x //mean(cx, owner_id.x)
          cy = owner_id.y //mean(cy, owner_id.y)
        }
        
        orbital_rot = point_direction(cx, cy, x, y) 
        //orbital_rot += angle_difference(orbital_rot, direction)/2
        
        orbital_dist = sprite_width*(mod_summon_movement_orbital_mod_count + is_summoned)
        mod_summon_movement_orbital_start = false
      }
      
      var mod_count = scr_queue_has_mod_count(step_event_queues_temp, scr_mod_summon_movement_orbital)+1;
      
      //for each modifier add in the calculations
      orbital_rot += (45/room_speed)*lag()
      
      if (orbital_rot >= 360) orbital_rot -= 360
      
      //reload the modifier
      //  this section is only here so we dont have to run the same mod 5 times but just
      //  once with the same calculations and just multiply the result by 5.
      if (mod_count = 1){
        //now that all modifiers are done adding to the new value we can adjust it's possition
        var new_x = cx+lengthdir_x(orbital_dist, orbital_rot)
        var new_y = cy+lengthdir_y(orbital_dist, orbital_rot)
        
        var xx = new_x - x;
        var yy = new_y - y;
        
        //now that we have our ideal vector we also need to find out the min vector
        var current_dist = point_distance(x, y, new_x, new_y);
        var error = min(current_dist, max_speed)/max_speed;
        
        
        if !is_summoned{
          //actually apply the inputs
          up += abs(sign(min(yy, 0))*error)
          down += sign(max(yy, 0))*error
          left += abs(sign(min(xx, 0))*error)
          right += sign(max(xx, 0))*error
        
        }else{//if it's a summon just mean the inputs with the player's inputs to try it's best to keep up
          up += mean( abs(sign(min(yy, 0))*error) , owner_id.up)
          down += mean( sign(max(yy, 0))*error , owner_id.down)
          left += mean( abs(sign(min(xx, 0))*error) , owner_id.left)
          right += mean( sign(max(xx, 0))*error , owner_id.right)
        }
        
        pre_x = new_x
        pre_y = new_y
        mod_summon_movement_orbital_start = true;
      }
    }
}

return false;



//if we're in the correct event then activate



