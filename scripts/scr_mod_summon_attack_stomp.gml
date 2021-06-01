///scr_mod_summon_attack_stomp()


///DESCRIPTION: When player is with in bounds of a stomp attack, start annimation, if the player leaves bounds when the fuse is up dont explode. Prevent movement while fuse is lit.
// Modcount = AOE size, and damage increase for explosion.
//
//summon step event



//Entity Check, find out of the object using this script is actually an entity
if (object_index = obj_summon) || (object_index = obj_enemy){
  
  
  //Check the mod count to help optimize math, and skip un needed script executions
  var mod_count = scr_queue_has_mod_count(step_event_queues_temp, scr_mod_summon_DESIGN)+1
  
  
  
  
  //init
  if !variable_instance_exists(self, "mod_summon_stomp_start"){
    //store what ever values are needed
    mod_summon_stomp_time = room_speed*0.666
    mod_summon_stomp_timer = 0
    mod_summon_stomp_cooldown_time = room_speed*1
    mod_summon_stomp_cooldown_timer = 0
    mod_summon_stomp_start = true
    
    mod_summon_stomp_explosion_size = one_tile + lerp(1.2*one_tile, 6*one_tile, (mod_count-1)/4)
    mod_summon_stomp_distance = mod_summon_stomp_explosion_size*0.666
    mod_summon_stomp_explosion_damage = e_damage
    mod_summon_stomp_explosion_knockback = e_damage
    mod_summon_stomp_explode = false
    
    //stat buffs
    //e_damage *= 1.05
  }
  
  
  //is this mod currently active? (for instance when the enemy is just finishing with a jump or shot, is the next jump/shot on a cool down?) This is primarily here incase another mod needs to highjack or prevent a specific mod from happening
  if (mod_summon_stomp_start){
    
    /////////////////////////
      //Secondary init, this is only activated on the second frame after every mod has be activated once, this is only a percasionary effect to make sure everything has added to values if needed.
      if !variable_instance_exists(self, "mod_summon_stomp_init"){
        mod_summon_stomp_init = true;
        //mod_summon_stomp_explosion_damage = self.e_health
      }
    /////////////////////////
    
    
    
    /////look for inputs/////
    if (mod_summon_stomp_timer = 0) && (mod_summon_stomp_cooldown_timer = 0){
      //if possessed, grab player inputs
      if is_possessed{
        var possessed_attack = possesser_id.item_a;
      }else{
        var possessed_attack = false;
      }
      
      var attack = false;
      //grab the desired inputs for this mod, sometimes they are the given inputs, or manipulated inputs, sometimes they are the mirrored inputs of the enemy.
      if (enemy != noone){
        if point_distance(enemy.x, enemy.y, x, y) < mod_summon_stomp_distance{
          var attack = true;
        }
      }
      
      //add the two inputs as desired, or simply take the player inputs, either way.
         //This is also where you will add any bias to the movements
      if (attack || possessed_attack){
        mod_summon_stomp_timer = mod_summon_stomp_time
      }
    }
    /////////////////////////  
    
    
      
    ///if cooldown is needed
    if (mod_summon_stomp_timer > 0)  && (mod_summon_stomp_cooldown_timer = 0){
    
      mod_summon_stomp_timer -= 1*lag()
      
      if (mod_summon_stomp_timer <= 0){
        
        mod_summon_stomp_timer = 0;
        
        //set the cooldown timer, make it shorter if it's a player possessed enemy
        if is_possessed{
          mod_summon_stomp_cooldown_timer = mod_summon_stomp_cooldown_time*0.5;
        }else{
          mod_summon_stomp_cooldown_timer = mod_summon_stomp_cooldown_time;
        }
        
        //change active states, or explode
        if instance_exists(enemy) && (point_distance(enemy.x, enemy.y, x, y) < mod_summon_stomp_explosion_size){
          
          mod_summon_stomp_explode = true
          deal_damage_radius(mod_summon_stomp_explosion_size, mod_summon_stomp_explosion_damage, false, false)
          deal_knockback_radius(mod_summon_stomp_explosion_size, mod_summon_stomp_explosion_damage)
          draw_particle_aoe_circle(prt_aoe_explosion, x, y, mod_summon_stomp_explosion_size+(one_tile*0.5), 0.4*room_speed, c_white)
          
          //this would be the entities final hurrah, lets cut the modifier off since nothing else will matter. "Admiral Ackbar!!"
          return true;
          
        }else{
          mod_summon_stomp_timer = 0;
        }
      }
    
    }
    
    //handle the attack cool down
    if (mod_summon_stomp_cooldown_timer > 0){
      mod_summon_stomp_cooldown_timer -= 1*lag();
      
      if (mod_summon_stomp_cooldown_timer <= 0){
        mod_summon_stomp_cooldown_timer = 0;
      }
    }
    
    
    //to prevent the mod from running an additional time this frame for no reason, simply turn off the active state of the mod.
    mod_summon_stomp_start = false
  }
  
  
  
  //if we're finished with the last mod for this frame, lets reset the mod count
  if (mod_count = 1){
    mod_summon_stomp_start = true
  }
  
  
}
