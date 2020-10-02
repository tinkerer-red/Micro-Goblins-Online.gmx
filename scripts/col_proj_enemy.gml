///col_proj_enemy()

var returned = false

//if sgs_place_meeting_c_s(global.entity_sgs_field, x, y, obj_entity){
if place_meeting(x, y, obj_entity){
  var proj_id = id
  var _dist = 999999999
  var collided_entity = noone
  
  with obj_entity {
    //remove the non possible entities
    if id = other.owner_id continue;
    if variable_instance_exists(id,"owner_id") {
      if (owner_id = other.owner_id) continue;
    }
    //if variable_instance_exists(id,"hp") {
    //  if (hp <= 0) continue;
    //}
    if point_distance(x, y, proj_id.x, proj_id.y) > (_dist) continue;
    
    if place_meeting(x, y, proj_id){
      //if it's actually colliding grab the needed variables
      var _dist = point_distance(x, y, proj_id.x, proj_id.y)
      var collided_entity = id
    }
  }
  
  if !(collided_entity = noone){
    self.pre_collide = true
    collide_entity = true
    
    returned = true
  }else{ //if we collided with a non valid object
    //self.collide = false
    //self.pre_collide = false
    
  }
}

return returned;
