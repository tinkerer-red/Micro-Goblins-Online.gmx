///scr_mod_sticky
//
//collision modifier

//show_debug_message("scr_mod_sticky")

var returned = false


///define variables on first launch
if !variable_instance_exists(self.id, "sticky_start"){
  self.sticky_start = true
  
  var mod_sticky_mod_count = scr_queue_has_mod_count(active_queue, scr_mod_sticky);
  
  
  //stick timer
  mod_sticky_timer = room_speed*mod_sticky_mod_count
  speed = 0
  
  
  if (collide_enemy){
    if instance_exists(collide_enemy){
      //if the projectile isn't actually inside the enemy,
      //just push it over slightly and re angle it so it doesnt look like it's unfair
      //even though it's unfair for the player, users will likely feel like the game is holding their hand
      var ideal_dir = point_direction(x,y,collide_enemy.x,collide_enemy.y);
      var ang_diff = angle_difference(direction, ideal_dir);
      direction -= (ang_diff/2.5)
      image_angle = direction-45
      
      x += lengthdir_x(5,ideal_dir)
      y += lengthdir_y(5,ideal_dir)
      
      
      //for enemy collision remember which angle and offset we initially stuck to it at
      mod_sticky_stick_to_angle = image_angle
      mod_sticky_stick_to_xoff = x-collide_enemy.x
      mod_sticky_stick_to_yoff = y-collide_enemy.y
      
      
      if (object_index = obj_weapon)
      || (object_index = obj_weap_proj){
        deal_tick_damage(collide_enemy, w_damage/(room_speed*0.8), mod_sticky_timer, owner_id)
      }else{//if it's a player, summon, tile, enemy, boss, etc
        deal_tick_damage(collide_enemy, w_damage/(room_speed*0.8), mod_sticky_timer, self)
      }
      
      //massiveley drop the DPS
      w_damage *= .25
      
    }
  }
}



if self.sticky_start {
  ///for all three types of collision we have different effects,
  
  if (collide_solid){
    //just sit there looking pretty
  }
  if (collide_ground){
    //just sit there looking pretty
  }
  if (collide_enemy){
    
    if instance_exists(collide_enemy){
      //stick to the enemy
      stick_to_angle(collide_enemy, mod_sticky_stick_to_xoff, mod_sticky_stick_to_yoff, mod_sticky_stick_to_angle)
    }
  }
  
  mod_sticky_timer -= 1*lag()
  
  if (mod_sticky_timer <= 0){
    return true;
  }
}

if (object_index != obj_weap_proj) {
  return true;
}

return false;
