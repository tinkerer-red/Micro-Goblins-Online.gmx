///scr_mod_summon_movement_walk()


///DESCRIPTION: What the mod should do
// Modcount = What does mod count effect
//
//summon step event



//Entity Check, find out of the object using this script is actually an entity
if (object_index = obj_summon) || (object_index = obj_enemy){
  
  
  //Check the mod count to help optimize math, and skip un needed script executions
  var mod_count = scr_queue_has_mod_count(step_event_queues_temp, scr_mod_summon_movement_walk)+1
  
  
  //init
  if !variable_instance_exists(self, "mod_summon_movement_walk_start"){
    //store what ever values are needed
    mod_summon_movement_walk_start = true
    mod_summon_movement_walk_speed = lerp(0.33, 1.5, (mod_count-1)/4)
    self.max_speed += 0.15*mod_count
  }
  
  
  
  //is this mod currently active? (for instance when the enemy is just finishing with a jump or shot, is the next jump/shot on a cool down?) This is primarily here incase another mod needs to highjack or prevent a specific mod from happening
  if (mod_summon_movement_walk_start)
  && (move_active){
   
    /////look for inputs/////
      
      //grab the desired inputs for this mod, sometimes they are the given inputs, or manipulated inputs, sometimes they are the mirrored inputs of the enemy.
      var mod_vector_x = ideal_vector_x;
      var mod_vector_y = ideal_vector_y;
      
      //if possessed, grab player inputs
      if is_possessed{
        var dir = point_direction(0, 0, possesser_id.right - possesser_id.left, possesser_id.down - possesser_id.up)
        //var dis = 
        show_debug_player("spd = "+string(spd))
        var mod_vector_x = lengthdir_x(1, dir);
        var mod_vector_y = lengthdir_y(1, dir);
        var mod_vector_x = possesser_id.right - possesser_id.left;
        var mod_vector_y = possesser_id.down - possesser_id.up;
      
      }
      
      //add the two inputs as desired, or simply take the player inputs, either way.
         //This is also where you will add any bias to the movements
      var true_vector_x = mod_vector_x;
      var true_vector_y = mod_vector_y;
    /////////////////////////  
    
    
    //apply movement
    vector_to_inputs(true_vector_x, true_vector_y, mod_summon_movement_walk_speed)
    
    
    //to prevent the mod from running an additional time this frame for no reason, simply turn off the active state of the mod.
    mod_summon_movement_walk_start = false
  }
  
  
  
  //if we're finished with the last mod for this frame, lets reset the mod count
  if (mod_count = 1){
    mod_summon_movement_walk_start = true
  }
  
  
}
