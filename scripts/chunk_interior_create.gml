///chunk_interior_create(x, y)

var xx = argument0;
var yy = argument1;

var cell_x = xx div global.chunk_handler.chunk_width;
var cell_y = yy div global.chunk_handler.chunk_width;

var tile_x = (xx - cell_x) div global.chunk_handler.tile_size;
var tile_y = (yy - cell_y) div global.chunk_handler.tile_size;

var _chunk_string = chunk_string(cell_x, cell_y)


//if the cell already exists, dont try to make a new one
if ds_map_exists(global.chunk_handler.active_interior_chunks, _chunk_string){
  return false;
}

//find first open interior zone.
var open_zone = 0;
var key = ds_map_find_first(global.chunk_handler.active_interior_chunks);
var map = global.chunk_handler.active_interior_chunks[? key]
if (map != undefined){
  open_zone = map[? "zone_pos"]+1;
}

while not (key = undefined){
    show_debug_message("repeat loop")
    key = ds_map_find_next(key, global.chunk_handler.active_interior_chunks)
    var map = global.chunk_handler.active_interior_chunks[? key]
    if (map != undefined){
      if (map[? "zone_pos"] >= open_zone){
        show_debug_message("if >=")
        open_zone = map[? "zone_pos"]+1
      }
    }
}



//init the map
var interior_map = ds_map_create()
var room_grid = ds_grid_create(16, 16) //all interiors will be 16x16 rooms large a room is 3x3 chunks
var room_connections_grid = ds_grid_create(16, 16) //all interiors will be 16x16 rooms large a room is 3x3 chunks
var chunk_id_grid = ds_grid_create(48,48)
ds_grid_clear(room_grid, "")
ds_grid_clear(chunk_id_grid, noone)

//add to this interior's map
ds_map_add(interior_map, "zone_pos", open_zone)
ds_map_add(interior_map, "room_grid", room_grid)
ds_map_add(interior_map, "room_connections_grid", room_connections_grid)
ds_map_add(interior_map, "chunk_id_grid", chunk_id_grid)

//add interior map to the active interiors list map
ds_map_add_map(global.chunk_handler.active_interior_chunks, _chunk_string, interior_map)

var _json = json_encode(global.chunk_handler.active_interior_chunks)
show_debug_message(_json)


//find out what structure we're generating
var _struct = chunk_tile_find(xx, yy, "layer_structures")




//generate the interior based on what structure it was
switch(_struct)
{
    case 1: chunk_generate_interior(cell_x, cell_y, 1, 0, interior_map); break;
    case 2: chunk_generate_interior(cell_x, cell_y, 2, 0, interior_map); break;
    case 3: chunk_generate_interior(cell_x, cell_y, 3, 0, interior_map); break;
    case 4: chunk_generate_interior(cell_x, cell_y, 4, 0, interior_map); break;

}





/*
// remember the chunk
//chunk_remember(cell_x, cell_y, chunk)


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



