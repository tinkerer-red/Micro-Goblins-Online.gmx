///chunk_call(cell_x,cell_y)
var timeStart = get_timer();

var cell_x = argument0;
var cell_y = argument1;

//if the cell already exists, dont try to make a new one
with (obj_chunk){
  if (chunk_x = cell_x) && (chunk_y = cell_y) return false;
}


var chunk = instance_create(cell_x*chunk_width, cell_y*chunk_height, obj_chunk);
chunk.image_xscale  = chunk_width
chunk.image_yscale = chunk_height

chunk.chunk_x = cell_x
chunk.chunk_y = cell_y

chunk.world_name = world_name;
chunk.chunk_dist = global.chunk_handler.chunk_dist

chunk.show_chunks = show_chunks;
chunk.loadid = -1


with (chunk) {
  event_user(0); 
  alarm_set(0, room_speed*60); //set the initial alarm to 1 minute to evenly space out the supervisor saving from the initial cell's saving
  //alarm_set(0, room_speed*60*2);
}
var timeEnd = get_timer();
var time= timeEnd - timeStart;
show_debug_message("spawn = "+string(time))

return true;



