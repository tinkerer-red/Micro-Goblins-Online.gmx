///scr_mod_summon_attack_kamikaze()


///DESCRIPTION: Where player is with in bounds of explosion, start fuse, if the player leaves bounds when the fuse is up dont explode. Prevent movement while fuse is lit.
// Modcount = AOE size, and damage increase for explosion.
//
//summon step event



//Entity Check, find out of the object using this script is actually an entity
if (object_index = obj_summon) || (object_index = obj_enemy){
  
  
  //Check the mod count to help optimize math, and skip un needed script executions
  var mod_count = scr_queue_has_mod_count(step_event_queues_temp, scr_mod_summon_DESIGN)+1
  
  
  
  
  //init
  if !variable_instance_exists(self, "mod_summon_kamikaze_start"){
    //store what ever values are needed
    mod_summon_kamikaze_time = lerp( 2*room_speed, 0.33*room_speed, (mod_count-1)/4)
    mod_summon_kamikaze_timer = 0
    mod_summon_kamikaze_start = true
    
    mod_summon_kamikaze_explosion_size = one_tile + lerp(2*one_tile, 4*one_tile, (mod_count-1)/4)
    mod_summon_kamikaze_distance = mod_summon_kamikaze_explosion_size*0.666
    mod_summon_kamikaze_explosion_damage = mod_count + e_damage + (self.e_health/4)
    mod_summon_kamikaze_explode = false
    
    //stat buffs
  }
  
  
  //is this mod currently active? (for instance when the enemy is just finishing with a jump or shot, is the next jump/shot on a cool down?) This is primarily here incase another mod needs to highjack or prevent a specific mod from happening
  if (mod_summon_kamikaze_start){
    
    /////////////////////////
      //Secondary init, this is only activated on the second frame after every mod has be activated once, this is only a percasionary effect to make sure everything has added to values if needed.
      if !variable_instance_exists(self, "mod_summon_kamikaze_init"){
        mod_summon_kamikaze_init = true;
        mod_summon_kamikaze_explosion_damage = self.e_health
      }
    /////////////////////////
    
    
    
    //On death, explode regardless of the enemy location
    if (e_health = 0){
      mod_summon_kamikaze_explode = true
      deal_damage_radius(mod_summon_kamikaze_explosion_size, mod_summon_kamikaze_explosion_damage, false, true)
      draw_particle_aoe_circle(prt_aoe_explosion, x, y, mod_summon_kamikaze_explosion_size+(one_tile*0.5), 0.4*room_speed, c_white)
      return true;
    }
    
    
    
    /////look for inputs/////
    if (mod_summon_kamikaze_timer = 0){
      //if possessed, grab player inputs
      if is_possessed{
        var possessed_attack = possesser_id.item_c;
      }else{
        var possessed_attack = false;
      }
      
      var attack = false;
      //grab the desired inputs for this mod, sometimes they are the given inputs, or manipulated inputs, sometimes they are the mirrored inputs of the enemy.
      if (enemy != noone){
        if point_distance(enemy.x, enemy.y, x, y) < mod_summon_kamikaze_distance{
          var attack = true;
        }
      }
      
      //add the two inputs as desired, or simply take the player inputs, either way.
         //This is also where you will add any bias to the movements
      if (attack || possessed_attack){
        mod_summon_kamikaze_timer = mod_summon_kamikaze_time
      }
    }
    /////////////////////////  
    
    
      
    ///if cooldown is needed
    if (mod_summon_kamikaze_timer > 0){
    
      mod_summon_kamikaze_timer -= 1*lag()
      
      if (mod_summon_kamikaze_timer <= 0){
        //change active states, or explode
        if instance_exists(enemy) && (point_distance(enemy.x, enemy.y, x, y) < mod_summon_kamikaze_explosion_size){
          
          mod_summon_kamikaze_explode = true
          //show_debug_message("mod_summon_kamikaze_explosion_damage = "+string(mod_summon_kamikaze_explosion_damage))
          deal_damage_radius(mod_summon_kamikaze_explosion_size, mod_summon_kamikaze_explosion_damage, false, true)
          draw_particle_aoe_circle(prt_aoe_explosion, x, y, mod_summon_kamikaze_explosion_size+(one_tile*0.5), 0.4*room_speed, c_white)
          e_health = 0
          
          
          //   V    This is no longer tru because many modifiers activate after death
          //this would be the entities final hurrah, lets cut the modifier off since nothing else will matter. "Admiral Ackbar!!"
          //return true;
          
        }
          mod_summon_kamikaze_timer = 0;
      }
    
    }
    
    
    //to prevent the mod from running an additional time this frame for no reason, simply turn off the active state of the mod.
    mod_summon_kamikaze_start = false
  }
  
  
  
  //if we're finished with the last mod for this frame, lets reset the mod count
  if (mod_count = 1){
    mod_summon_kamikaze_start = true
  }
  
  
}
