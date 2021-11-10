///scr_mod_summon_health_multiply()


///DESCRIPTION: on death multiply
// Modcount = how many times they can be revived
//
//summon step event



//Entity Check, find out of the object using this script is actually an entity
if (object_index = obj_summon) || (object_index = obj_enemy){
  
  
  //Check the mod count to help optimize math, and skip un needed script executions
  var mod_count = scr_queue_has_mod_count(step_event_queues_temp, scr_mod_summon_health_multiply)+1
  
  
  
  
  //init
  if !variable_instance_exists(self, "mod_summon_health_multiply_start"){
    //store what ever values are needed
    //mod_summon_health_multiply_timer = room_speed
    mod_summon_health_multiply_start = false
    
    //stat buffs
    //this modifier is a bit too strong so it's not going to get any
  }
  
  
  
  
  //is this mod currently active? (for instance when the enemy is just finishing with a jump or shot, is the next jump/shot on a cool down?) This is primarily here incase another mod needs to highjack or prevent a specific mod from happening
  if (mod_summon_health_multiply_start){
    
    
    //Secondary init, this is only activated on the second frame after every mod has be activated once, this is only a percasionary effect to make sure everything has added to values if needed.
    if !variable_instance_exists(self, "mod_summon_health_multiply_init"){
      mod_summon_health_multiply_init = true;
      
      //remember the max stats of the summon for the next revive
      mod_summon_health_multiply_max_health = e_health/(mod_count+1)
      mod_summon_health_multiply_max_damage = e_damage/(mod_count+1)
      
    }
    
    
    //check for death
    if (e_health <= 0){
      //reset the stats
      e_health = mod_summon_health_multiply_max_health * mod_count
      e_damage = mod_summon_health_multiply_max_damage * mod_count
      
      //remove the old multiply before we clone
      ds_priority_delete_value(self.step_event_queues, scr_mod_summon_health_multiply)
      ds_priority_delete_value(self.step_event_queues_temp, scr_mod_summon_health_multiply)
      
      //clone
      var clone = instance_copy(false);
      
      if instance_exists(clone){
        clone.x += htme_random_range(-0.1, 0.1)
        clone.y += htme_random_range(-0.1, 0.1)
      }
      return true;
    }
    
    
    
    //to prevent the mod from running an additional time this frame for no reason, simply turn off the active state of the mod.
    mod_summon_health_multiply_start = false
  }
  
  
  
  //if we're finished with the last mod for this frame, lets reset the mod count
  if (mod_count = 1){
    mod_summon_health_multiply_start = true
  }
  
  
}


//only ever return true if the modifier is no longer needed, doing so will remove one of the modifier from the queue.
return false
