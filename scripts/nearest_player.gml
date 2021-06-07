///nearest_player(x, y, radius)

var xx = argument0
var yy = argument1
var radius = argument2


var list = collision_circle_list(xx, yy, radius, obj_player, -1, true)

//show_debug_message(ds_list_size(list))

var nearest_dist = 9999999;
var returned_target = noone;

//if the list is empty just return nothing before going any further
if (list = noone){
  return noone;
}

while !ds_list_empty(list) {
  //if the distance is less then the previous distance (or less than infinate)
  var _dist = point_distance(xx, yy, list[| 0].x, list[| 0].y)
  if (_dist < nearest_dist) && (_dist < radius){
    var returned_target = list[| 0];
    nearest_dist = _dist
  }
  
  ds_list_delete(list, 0);
}

ds_list_destroy(list);

return returned_target;



