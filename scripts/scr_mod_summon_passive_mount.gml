///scr_mod_summon_passive_mount()


///DESCRIPTION: What the mod should do
// Modcount = What does mod count effect
//
//summon step event



//Entity Check, find out of the object using this script is actually an entity
if (object_index = obj_summon) || (object_index = obj_enemy){
  
  
  //Check the mod count to help optimize math, and skip un needed script executions
  var mod_count = scr_queue_has_mod_count(step_event_queues_temp, scr_mod_summon_DESIGN)+1
  
  
  
  
  //init
  if !variable_instance_exists(self, "mod_summon_mount_start"){
    //store what ever values are needed
    mod_summon_mount_timer = room_speed;
    mod_summon_mount_start = false;
    is_mounted = false;
    mounted_id = noone;
    just_mounted = false;
    mount_count = mod_count;
    image_xscale += 0.2*mod_count;
    image_yscale += 0.2*mod_count;
    
    //stat buffs
  }
  
  
  
  
  //is this mod currently active? (for instance when the enemy is just finishing with a jump or shot, is the next jump/shot on a cool down?) This is primarily here incase another mod needs to highjack or prevent a specific mod from happening
  if (mod_summon_mount_start){
    
    
    //Secondary init, this is only activated on the second frame after every mod has be activated once, this is only a percasionary effect to make sure everything has added to values if needed.
    if !variable_instance_exists(self, "mod_summon_mount_init"){
      mod_summon_mount_init = true;
    }
    
    
    if (!is_mounted){
      //find the nearest ally
      var ally = nearest_ally(x,y,one_tile*1.5+fast_hype(sprite_width, sprite_height))
      
      if (ally != noone){
      
        if (ally.object_index = obj_player){
          ////////////////////REPLACE THE PLAYER'S ACTIVATE BUTTON PROMPT WITH "MOUNT"////////////////////
          ////////////////////////////////////////////////////////////////////////////////////////////////
          ////////////////////////////////////////////////////////////////////////////////////////////////
          
          
          //If the player presses their activate button, mount the AI
          if (ally.action_pressed) && (!ally.is_jocky) && (!ally.just_dismounted){
            just_mounted = true;
            mounted_id = ally
            is_mounted = true
            possesser_id = ally
            is_possessed = true
            //remind the entity they are not able to use any items while being a jocky
            mounted_id.is_jocky = true
          }
        }
      }
    }
    
    //if something is mounting the AI
    if (is_mounted) && (mounted_id != noone){
      
      ///debug tools
      if (mounted_id.object_index = obj_player){
        show_debug_player("mounted")
      }
      
      //move the jocky ontop of the mount
      mounted_id.x = x
      mounted_id.y = y+4
      
      //update the jocky's invulnerable state
      mounted_id.iframes = room_speed
      mounted_id.invulnerable = true
      
      //if the player would like to dismount, OR if the entity has died
      if (!just_mounted && (mounted_id.object_index = obj_player) && (mounted_id.action_pressed)) //check to see if the player would like to dismount, but never do this if we just mounted
      || (e_health = 0){ //if the entity has died
        //allow the jocky to use any items again
        mounted_id.is_jocky = false
        mounted_id = noone
        is_mounted = false
        possesser_id = noone
        is_possessed = false
      }
    }      
    
    
    
    //to prevent the mod from running an additional time this frame for no reason, simply turn off the active state of the mod.
    mod_summon_mount_start = false
  }
  
  
  
  //if we're finished with the last mod for this frame, lets reset the mod count
  if (mod_count = 1){
    mod_summon_mount_start = true
    just_mounted = false;
  }
}


//only ever return true if the modifier is no longer needed, doing so will remove one of the modifier from the queue.
return false
