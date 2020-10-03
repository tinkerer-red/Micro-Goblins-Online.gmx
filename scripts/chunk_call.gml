///chunk_call(cell_x,cell_y)


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
  alarm_set(0, room_speed*60*2);
}

return true;



