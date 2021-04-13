///chunk_uncall_region(world_x, world_y)


var xx = argument0;
var yy = argument1;

var reach = chunk_dist+margin

if (sign(xx) = -1) {var x_sign = -1} else {var x_sign = 0}
if (sign(yy) = -1) {var y_sign = -1} else {var y_sign = 0}

var cell_x = (xx div chunk_width) + x_sign
var cell_y = (yy div chunk_height) + y_sign
//*
for (var i = -reach; i <= reach; i++){
  for (var j = -reach; j <= reach; j++){
    chunk_uncall(cell_x+i, cell_y+j)
  }
}

//*/

