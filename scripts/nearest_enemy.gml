///nearest_enemy(x, y, radius)

var xx = argument0
var yy = argument1
var radius = argument2


var list = collision_circle_list(xx, yy, radius, obj_entity, -1, true)

var nearest_dist = 9999;
var returned_target = noone;

//if the list is empty just return nothing before going any further
if (list = noone){
  return noone;
}

while !ds_list_empty(list) {
  
  if is_enemy(list[| 0].id) && (list[| 0].id != id)
  {
    //if we are a projectile, melee weapon, or summon ignore your owner
    if variable_instance_exists(id, "owner_id"){
      if (list[| 0] = owner_id){
        ds_list_delete(list, 0);
        continue;
      }
    }
    
    var _dist = point_distance(xx, yy, list[| 0].x, list[| 0].y)
    
    if (_dist < nearest_dist){
      var returned_target = list[| 0];
    }
  }
  
  ds_list_delete(list, 0);
}

ds_list_destroy(list);

return returned_target;



