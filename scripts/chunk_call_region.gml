///chunk_call_region(world_x, world_y)

var xx = argument0;
var yy = argument1;

if (sign(xx) = -1) {var x_sign = -1} else {var x_sign = 0}
if (sign(yy) = -1) {var y_sign = -1} else {var y_sign = 0}

var cell_x = (xx div chunk_width) + x_sign
var cell_y = (yy div chunk_height) + y_sign

//call center chunk
//chunk_call(cell_x, cell_y)
//call the rest of the chunks
var timeStart = get_timer();

for (var i = -chunk_dist; i <= chunk_dist; i++){
  for (var j = -chunk_dist; j <= chunk_dist; j++){
    chunk_call(cell_x+i, cell_y+j)
  }
}
var timeEnd = get_timer();
var time= timeEnd - timeStart;
show_debug_message("loops = "+string(time))




