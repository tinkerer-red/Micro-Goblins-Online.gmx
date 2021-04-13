///col_proj_enemy()
if (ticked_over()){
  var collided_entity = collision_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, obj_entity, false, true)
  
  collide_enemy = noone
  
  if (collided_entity = noone) return false;
  
  if is_enemy(collided_entity){
    self.pre_collide = true
    collide_enemy = collided_entity
    return true;
  }else{ //if we collided with a non valid object
    //self.collide = false
    //self.pre_collide = false
  }
}

return false;
