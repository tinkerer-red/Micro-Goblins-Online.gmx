/// scr_mod_bonusShot()


if !to_much_lag(){

  if (w_type = weapon_type_range) || (melee_ranged > 0){
    
    //make sure we haven't created to many projectiles
    var count = ds_queue_size(self.proj_queue)
    if count > 1000
    || (fps < 10){return true;}
    
    var _dir = htme_random_range(0, 360)
    var _acc = htme_random_range(-22.5, 22.5)
    
    var distance = ((owner_id.sprite_width*owner_id.image_xscale) + (owner_id.sprite_height*owner_id.image_yscale))/2
    
    xx = owner_id.x+lengthdir_x(distance, _dir);
    yy = owner_id.y+lengthdir_y(distance, _dir);
    
    var new_proj = instance_create(xx, yy, obj_weap_proj)
          
    ds_queue_enqueue(self.recent_proj_queue, new_proj)
    ds_queue_enqueue(self.proj_queue, new_proj)
    ///set variables for new projectile
          
    new_proj.owner_weap = id
    new_proj.owner_id = owner_id
    new_proj.direction = direction+_acc
      
  }
}
return true
