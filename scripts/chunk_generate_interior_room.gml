///chunk_generate_interior_room()

//should be called only by the chunk it's self

// let future scripts know this is a new cell, to prevent map comparasons.
generated = true;

var array = interior_chunk_find_grid_pos(chunk_x,chunk_y)

//show_debug_message("array = "+string(array))

if (array = undefined){
  should_exist = false
  return false;
}


interior_grid_x = array[0]
interior_grid_y = array[1]
interior_map = array[2]


var room_grid = interior_map[? "room_grid"]
var interior_zone_size = interior_map[? "interior_zone_size"]
var entry_x = interior_map[? "entry_x"]
var entry_y = interior_map[? "entry_y"]


interior_string = room_grid[# interior_grid_x, interior_grid_y]


if (interior_string = ""){
  //should_exist = false
  return false;
}


//if there is no room in a cardinal direction of the room we are generating, we will replace the open door areas with walls
//up
if (interior_grid_y-1 <0) || (room_grid[# interior_grid_x, interior_grid_y-1] = ""){
  //the encoding goes Y value, then X value in the tilemap.
  interior_string =string_delete(interior_string, 449, 2)
  interior_string =string_insert("10",interior_string, 449)
  interior_string =string_delete(interior_string, 513, 2)
  interior_string =string_insert("10", interior_string, 513)
}
//down
if (interior_grid_y+1 > interior_zone_size) || (room_grid[# interior_grid_x, interior_grid_y+1] = ""){
  //exclusively for down we must also check if this is currently the entry/exit room
  var chunk_array = xy_to_chunk(entry_x, entry_y)
  var entry_chunk_coords_array = interior_chunk_find_grid_pos(chunk_array[0], chunk_array[1], interior_map)
  
  if (entry_chunk_coords_array[0] != interior_grid_x
  && entry_chunk_coords_array[1] != interior_grid_y){
    interior_string =string_delete(interior_string, 509, 2)
    interior_string =string_insert("10", interior_string, 509)
    interior_string =string_delete(interior_string, 573, 2)
    interior_string =string_insert("10", interior_string, 573)
  }
}
//left
if (interior_grid_x-1 <0) || (room_grid[# interior_grid_x-1, interior_grid_y] = ""){
  interior_string =string_delete(interior_string, 29, 2)
  interior_string =string_insert("10", interior_string, 29)
  interior_string =string_delete(interior_string, 33, 2)
  interior_string =string_insert("10", interior_string, 33)
}
//right
if (interior_grid_x+1 > interior_zone_size) || (room_grid[# interior_grid_x+1, interior_grid_y] = ""){
  interior_string =string_delete(interior_string, 989, 2)
  interior_string =string_insert("10", interior_string, 989)
  interior_string =string_delete(interior_string, 993, 2)
  interior_string =string_insert("10", interior_string, 993)
}
//*/

var str = interior_string


var tile_size = global.chunk_handler.tile_size
var width = sprite_width/tile_size
var height = sprite_height/tile_size
obsticals_grid = ds_grid_create(width, height)

for(var i = 0; i < width; i++){
  for(var j = 0; j < height; j++){
    //map all hex values to a sprite and switch
    var tile_str = string_copy(str, 1, 2)
    var switch_str = string_copy(str, 2, 2)
    str = string_delete(str, 1, 4)
    chunk_generate_interior_room_tileID_to_grid(i, j, tile_str, switch_str)
    //var value = hex_to_dec(tile_str);
    //obsticals_grid[# i, j] = value
  }
}


