///chunk_generate_interior_room()

//should be called only by the chunk it's self

// let future scripts know this is a new cell, to prevent map comparasons.
generated = true;

var array = interior_chunk_find_grid_pos(chunk_x,chunk_y)
if (array = undefined){
  should_exist = false
  return false;
}

interior_grid_x = array[0]
interior_grid_y = array[1]
interior_map = array[2]
//show_debug_message("interior_grid_x = "+string(interior_grid_x))
//show_debug_message("interior_grid_y = "+string(interior_grid_y))


var room_grid = interior_map[? "room_grid"]

interior_string = room_grid[# interior_grid_x, interior_grid_y]

if (interior_string = ""){
  //should_exist = false
  return false;
}

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
    var value = hex_to_dec(tile_str);
    obsticals_grid[# i, j] = value
  }
}

//ds_grid_print(room_grid)
//show_debug_message("Now has aquired interior string from generation")
//show_debug_message("interior_string = "+string(interior_string))

