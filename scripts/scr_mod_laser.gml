///scr_mod_laser()

//show_debug_message("scr_mod_laser")


//reduce cool down
owner_id.active_w_cooldown -= (room_speed*0.04) //2.5 for 30 fps


//drastically reduce damage since lasers are OP
owner_id.active_w_damage = (owner_id.active_w_damage*0.5)//*1.1



//For everything in the projectile queue, make a laser for it, this will make it very, very busted.
//Allowing for a max of 9 lasers to be shot out at once,
//probably more with creative players making use of the (melee + 3x ranged + mutishot + laser)
if (w_type = weapon_type_range) || (melee_ranged > 0){
  
  var mod_count = scr_queue_has_mod_count(active_queue, scr_mod_laser)
  var hype = sqrt( power(sprite_height,2) + power(sprite_width,2))
  
  var laser_mod_number = mod_count
  var laser_length = 3 + 2*laser_mod_number
  
  
  while ds_queue_size(self.recent_proj_queue) != 0{
    var _proj = ds_queue_dequeue(self.recent_proj_queue)
    
    
    //make lasers
    
    for (var i = 1; i <= laser_length; i++){
      var new_proj = instance_create(x, y, obj_weap_proj)
      
      ds_queue_enqueue(self.proj_queue, new_proj)
      
      var distance = (hype*(3 + 2*laser_mod_number-i));
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


        
return true  







