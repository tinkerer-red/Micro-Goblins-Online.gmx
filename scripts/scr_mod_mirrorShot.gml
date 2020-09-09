/// scr_mod_mirrorShot()



if (w_type = weapon_type_range) || (ranged = true){
  var _dir = direction-180
  
  var distance = ((self.sprite_width*self.image_xscale)/2 + (self.sprite_height*self.image_yscale)/2) /2 +1
  
  xx = owner_id.x+lengthdir_x(distance, _dir);
  yy = owner_id.y+lengthdir_y(distance, _dir);
  
  var new_proj = instance_create(xx, yy, obj_weap_proj)
        
  ds_queue_enqueue(self.recent_proj_queue, new_proj)
  ds_queue_enqueue(self.proj_queue, new_proj)
  ///set variables for new projectile
        
  new_proj.direction = _dir
        
}

return true
