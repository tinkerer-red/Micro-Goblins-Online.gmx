/// scr_mod_bonusShot()



if (w_type = weapon_type_range) || (ranged = true){
  var _dir = random_range(0, 360)
  var _acc = random_range(-22.5, 22.5)
  
  var distance = ((owner_id.sprite_width*owner_id.image_xscale) + (owner_id.sprite_height*owner_id.image_yscale))/2
  
  xx = owner_id.x+lengthdir_x(distance, _dir);
  yy = owner_id.y+lengthdir_y(distance, _dir);
  
  var new_proj = instance_create(xx, yy, obj_weap_proj)
        
  ds_queue_enqueue(self.recent_proj_queue, new_proj)
  ds_queue_enqueue(self.proj_queue, new_proj)
  ///set variables for new projectile
        
  new_proj.direction = direction+_acc
        
}

return true
