///chunk_uncall_region(world_x, world_y)


var xx = argument0;
var yy = argument1;

var reach = chunk_dist+3

if (sign(xx) = -1) {var x_sign = -1} else {var x_sign = 0}
if (sign(yy) = -1) {var y_sign = -1} else {var y_sign = 0}

var cell_x = (xx div chunk_width) + x_sign
var cell_y = (yy div chunk_height) + y_sign
/*
show_debug_message("xx = "+string(xx))
show_debug_message("yy = "+string(yy))
show_debug_message("(xx div chunk_width) = "+string(xx div chunk_width))
show_debug_message("(yy div chunk_height) = "+string(yy div chunk_height))
show_debug_message("x_sign = "+string(x_sign))
show_debug_message("y_sign = "+string(y_sign))
show_debug_message("cell_x = "+string(cell_x))
show_debug_message("cell_y = "+string(cell_y))
*/
for (var i = -reach; i <= reach; i++){
  for (var j = -reach; j <= reach; j++){
    chunk_uncall(cell_x+i, cell_y+j)
  }
}




