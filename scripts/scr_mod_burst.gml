///scr_mod_burst()

//show_debug_message("scr_mod_burst")


//reduce cool down
//owner_id.active_w_cooldown -= (room_speed*0.04) //2.5 for 30 fps

if !to_much_lag(){
  
  //drastically reduce damage since bursts are OP
  owner_id.active_w_damage = (owner_id.active_w_damage*0.5)//*1.1
  
  
  
  //For everything in the projectile queue, make a burst for it, this will make it very, very busted.
  //Allowing for a max of 9 bursts to be shot out at once,
  //probably more with creative players making use of the (melee + 3x ranged + mutishot + burst)
  if (w_type = weapon_type_range) || (melee_ranged > 0){
    
    var mod_count = scr_queue_has_mod_count(active_queue, scr_mod_burst)
    var hype = fast_hype(sprite_height, sprite_width)
    
    var burst_mod_number = mod_count
    var burst_length = 1 + burst_mod_number
    //we only do 2 for a mod count of one, because we are only adding 2 bullets to the initial one, so that way we have 3
    
    while ds_queue_size(self.recent_proj_queue) != 0{
      var _proj = ds_queue_dequeue(self.recent_proj_queue)
      
      //ds_queue_enqueue(self.proj_queue, _proj)
      //ds_queue_enqueue(self.recent_proj_queue, _proj)
      
      //make bursts
      for (var i = 1; i <= burst_length; i++){
        var new_proj = instance_create(x, y, obj_weap_proj)
        
        ds_queue_enqueue(self.proj_queue, new_proj)
        //ds_queue_enqueue(self.recent_proj_queue, new_proj)
        
        var distance = (hype*(2 + burst_mod_number-i));
        new_proj.direction = _proj.direction
        
        new_proj.x = _proj.x+lengthdir_x(distance, new_proj.direction);
        new_proj.y = _proj.y+lengthdir_y(distance, new_proj.direction);
        
        //we add the initial distance traveled so that cluster and ground collision activates all of the projectiles at the same location, preventing increased range buff
        new_proj.dis_traveled = distance
        
        new_proj.owner_weap = id
      }
    }
    
    
  }
  
  
  
  //reload the new projectiles into the original queue
  if (mod_count = 1){
    if ds_queue_size(self.recent_proj_queue) = 0{
      ds_queue_copy(self.recent_proj_queue, self.proj_queue)
    }
  }

}
        
return true  







