///col_with_player()

var returned = false;

var player = instance_nearest(x,y,obj_player)
if place_meeting(x, y, player) {
  returned = true
}


return returned
