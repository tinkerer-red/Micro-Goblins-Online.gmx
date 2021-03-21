///chunk_interior_create(x, y)

var xx = argument0;
var yy = argument1;

var cell_x = xx div global.chunk_handler.chunk_width;
var cell_y = yy div global.chunk_handler.chunk_width;

var tile_x = (xx - cell_x) div global.chunk_handler.tile_size;
var tile_y = (yy - cell_y) div global.chunk_handler.tile_size;

var tile_size = global.chunk_handler.tile_size

var _chunk_string = chunk_string(cell_x, cell_y)


//if the cell already exists, dont try to make a new one
if ds_map_exists(global.chunk_handler.active_interior_chunks, _chunk_string){
  var map = global.chunk_handler.active_interior_chunks
  var int_map = map[? _chunk_string]
  var xx = int_map[? "entry_x"]
  var yy = int_map[? "entry_y"]
  teleport(xx, yy, self.player_id_local)
  return false;
}

//find first open interior zone.
var open_zone = 0;
var key = ds_map_find_first(global.chunk_handler.active_interior_chunks);
var map = global.chunk_handler.active_interior_chunks[? key]
if (map != undefined){
  open_zone = map[? "zone_pos"]+1;
  show_debug_message("advanced open zone possition to "+string(open_zone))
}

while (key != undefined){
    show_debug_message("zone while loop")
    key = ds_map_find_next(global.chunk_handler.active_interior_chunks, key)
    if (key = undefined) break;
    show_debug_message("key = "+key)
    var map = global.chunk_handler.active_interior_chunks[? key]
    if (map != undefined){
      if (map[? "zone_pos"] >= open_zone){
        show_debug_message("if >=")
        open_zone = map[? "zone_pos"]+1
      }else{
        show_debug_message('map[? "zone_pos"] < open_zone')
      }
    }else{
      show_debug_message("map = undefined")
    }
}



//init the map
var interior_map = ds_map_create()
var room_grid = ds_grid_create(16, 16) //all interiors will be 16x16 rooms large a room is 3x3 chunks
var room_connections_grid = ds_grid_create(16, 16) //all interiors will be 16x16 rooms large a room is 3x3 chunks
var chunk_id_grid = ds_grid_create(16,16)
ds_grid_clear(room_grid, "")
ds_grid_clear(chunk_id_grid, noone)

//add to this interior's map
ds_map_add(interior_map, "zone_pos", open_zone)
ds_map_add(interior_map, "room_grid", room_grid)
ds_map_add(interior_map, "room_connections_grid", room_connections_grid)
ds_map_add(interior_map, "chunk_id_grid", chunk_id_grid)

//add interior map to the active interiors list map
ds_map_add_map(global.chunk_handler.active_interior_chunks, _chunk_string, interior_map)

//var _json = json_encode(global.chunk_handler.active_interior_chunks)
//show_debug_message(_json)


//find out what structure we're generating
var _struct = chunk_tile_find(xx, yy, "layer_structures")


ds_map_add(interior_map, "zone_pos", open_zone)

//store the exit location
        if ds_map_exists(global.chunk_handler.active_chunks, chunk_string(cell_x, cell_y)){
          var map = global.chunk_handler.active_chunks
          var chunk_id = map[? _chunk_string]
          var grid = chunk_id.structure_grid
          
          var grid_x = (xx - chunk_id.x) div tile_size
          var grid_y = (yy - chunk_id.y) div tile_size
        }
        
        var tile_count_h = global.chunk_handler.chunk_width div tile_size
        var tile_count_v = global.chunk_handler.chunk_height div tile_size
        
        //loop trhough the distance of interior chunks
          var up_i = 0
          var down_i = 0
          var left_i = 0
          var right_i = 0
          
          //up
          repeat(_struct){
            if (grid[# grid_x, grid_y-up_i] = _struct){
              up_i++
              continue;
            }
            if (grid_y-up_i < 0) break;
            break;
          }
          //down
          repeat(_struct){
            if (grid[# grid_x, grid_y+down_i] = _struct){
              down_i++
              continue;
            }
            if (grid_y+down_i >= tile_count_v) break;
            break;
          }
          //left
          repeat(_struct){
            if (grid[# grid_x-left_i, grid_y] = _struct){
              left_i++
              continue;
            }
            if (grid_x-left_i < 0) break;
            break;
          }
          //right
          repeat(_struct){
            if (grid[# grid_x+right_i, grid_y] = _struct){
              right_i++
              continue;
            }
            if (grid_x+right_i >= tile_count_h) break;
            break;
          }
          
          
          //now find the actual bounding boxes
          var bbox_struct_left = chunk_id.x + (grid_x-left_i)*tile_size
          var bbox_struct_up = chunk_id.y + (grid_y-up_i)*tile_size
          var bbox_struct_right = chunk_id.x + (grid_x+right_i)*tile_size
          var bbox_struct_down = chunk_id.y + (grid_y+down_i)*tile_size
        
        //now that we have the bounding box of the structure, we can find the center point
        var exit_x = bbox_struct_left + (bbox_struct_right - bbox_struct_left)/2
        var exit_y = bbox_struct_down + tile_size
        ds_map_add(interior_map, "exit_x", exit_x)
        ds_map_add(interior_map, "exit_y", exit_y)



//show_debug_message("chunk_interior_create switch start")
//show_debug_message("_struct = "+string(_struct))
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



