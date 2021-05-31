///scr_mod_summon_movement_jumpy()


///DESCRIPTION: Speratic jumps for movement, basically just a cosined walk.
// Modcount = number of jumps, and speed
//
//summon step event



//Entity Check, find out of the object using this script is actually an entity
if (object_index = obj_summon) || (object_index = obj_enemy){
  
  
  //Check the mod count to help optimize math, and skip un needed script executions
  var mod_count = scr_queue_has_mod_count(step_event_queues_temp, scr_mod_summon_movement_jumpy)+1
  
  
  //init
  if !variable_instance_exists(self, "mod_summon_movement_jumpy_start"){
    
    //store what ever values are needed
    mod_summon_movement_jumpy_time = room_speed*1.2
    mod_summon_movement_jumpy_timer = mod_summon_movement_jumpy_time
    mod_summon_movement_jumpy_start = false //for this particular mod, because we'll be adjusting the max speed dynamicly, we will wait for all mods to run one before we adjust anything.
    
    //store default inputs, because we only update these once every 2 seconds to imply leaping
    mod_summon_movement_jumpy_vector_x = ideal_vector_x;
    mod_summon_movement_jumpy_vector_y = ideal_vector_y;
    mod_summon_movement_jumpy_possessed_vector_x = 0;
    mod_summon_movement_jumpy_possessed_vector_y = 0;
    
    //stat buffs
    self.max_speed += 0.25*mod_count
  }
  
  
  
  //is this mod currently active? (for instance when the enemy is just finishing with a jump or shot, is the next jump/shot on a cool down?) This is primarily here incase another mod needs to highjack or prevent a specific mod from happening
  if (mod_summon_movement_jumpy_start){
    
    //this is basically a second init, to prevent mod info from being lost if they are in queue after this mod.
    if !variable_instance_exists(self, "mod_summon_movement_jumpy_max_speed"){ mod_summon_movement_jumpy_max_speed = self.max_speed }
    
    //decrement timer
    mod_summon_movement_jumpy_timer -= 1*lag()
    if (mod_summon_movement_jumpy_timer <= 0){
      mod_summon_movement_jumpy_timer = mod_summon_movement_jumpy_time
    }
    
    //leap multiplier, this value is just a cosine for the movement, so it can act more like a jump
    var leap_multiplier = clamp(-cos((mod_summon_movement_jumpy_timer/mod_summon_movement_jumpy_time)*pi*2*mod_count)+0.33, 0, 1);
    self.max_speed = lerp(mod_summon_movement_jumpy_max_speed*leap_multiplier, mod_summon_movement_jumpy_max_speed, 1-((mod_count-1)/4))
    
    /////look for inputs/////
      if (leap_multiplier = 0){
        //if possessed, grab player inputs
        if is_possessed{
          mod_summon_movement_jumpy_possessed_vector_x = possesser_id.down - possesser_id.up;
          mod_summon_movement_jumpy_possessed_vector_y = possesser_id.right - possesser_id.left;
        }else{
          mod_summon_movement_jumpy_possessed_vector_x = 0;
          mod_summon_movement_jumpy_possessed_vector_y = 0;
        }
        
        //grab the desired inputs for this mod, sometimes they are the given inputs, or manipulated inputs, sometimes they are the mirrored inputs of the enemy.
        mod_summon_movement_jumpy_vector_x = ideal_vector_x;
        mod_summon_movement_jumpy_vector_y = ideal_vector_y;
      } 
      
      //add the two inputs as desired, or simply take the player inputs, either way.
         //This is also where you will add any bias to the movements
      
      var true_vector_x = clamp( mod_summon_movement_jumpy_vector_x + mod_summon_movement_jumpy_possessed_vector_x, -1, 1);
      var true_vector_y = clamp( mod_summon_movement_jumpy_vector_y + mod_summon_movement_jumpy_possessed_vector_y, -1, 1);
    /////////////////////////  
    
    
    //apply movement
    vector_to_inputs(true_vector_x, true_vector_y, leap_multiplier*mod_count)
    
    
    
    
    //to prevent the mod from running an additional time this frame for no reason, simply turn off the active state of the mod.
    mod_summon_movement_jumpy_start = false
  }
  
  
  
  //if we're finished with the last mod for this frame, lets reset the mod count
  if (mod_count = 1){
    mod_summon_movement_jumpy_start = true
  }
  
  
}
