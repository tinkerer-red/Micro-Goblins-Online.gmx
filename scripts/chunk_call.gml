///chunk_call(cell_x,cell_y)

var cell_x = argument0;
var cell_y = argument1;

var xx = cell_x*global.chunk_handler.chunk_width
var yy = cell_y*global.chunk_handler.chunk_height



//for any reason the chunks shouldnt generate
  //if the cell already exists, dont try to make a new one
  if ds_map_exists(global.chunk_handler.active_chunks, chunk_string(cell_x, cell_y)){
    return false;
  }
  
  //make sure interior cells dont gen if the player isnt inside them
  if is_interior(xx,yy){
    if !chunk_interior_player_in_zone(cell_x, cell_y){
      return false;
    }
    if chunk_interior_exists(cell_x, cell_y){
      return false;
    }
  }
  
/*
///this check might be to laggy remove it later if it causes issues
if collision_point( xx, yy, obj_chunk, false, false){
  return false;
}
*/
var chunk = instance_create(cell_x*chunk_width, cell_y*chunk_height, obj_chunk);

// remember the chunk

chunk_remember(cell_x, cell_y, chunk)


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

return true;



