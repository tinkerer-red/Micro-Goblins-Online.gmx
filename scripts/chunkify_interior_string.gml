///chunkify_interior_string(x1, y1, string, interior_map)

//show_debug_message("==================================================")
//show_debug_message("==================================================")
//show_debug_message("==================================================")
//show_debug_message("chunkifying string")
//show_debug_message("==================================================")
//show_debug_message("==================================================")
//show_debug_message("==================================================")


var _x = argument0;
var _y = argument1;
var room_string = argument2;
var map = argument3;

var room_cells = global.chunk_handler.chunk_width div global.chunk_handler.tile_size


var width  = string_copy(room_string, 1, 2)
var height = string_copy(room_string, 3, 2)
room_string = string_delete(room_string, 1, 4)


var width  = hex_to_dec(width);
var height = hex_to_dec(height);

//CHECK TO MAKE SURE ALL ROOMS WILL BE EMPTY BEFORE WE WRITE
var room_grid = map[? "room_grid"]
for(var chunk_x = 0; chunk_x <= width; chunk_x++){
    for(var chunk_y = 0; chunk_y <= height; chunk_y++){
        if (_x+chunk_x < 0) || (_x+chunk_x > global.chunk_handler.interior_zone_size){
          show_debug_message("failed number one")
          return false;}
        if (_y+chunk_y < 0) || (_y+chunk_y > global.chunk_handler.interior_zone_size){
          show_debug_message("failed number two")
          return false;}
        if (room_grid[# _x+chunk_x, _y+chunk_y] != ""){
          show_debug_message("failed number three")
          return false;}
    }
}

//delete the doors variable because why would we need them? fuck em
//What the fuck was red on about when he added this? it doesnt do anything, it's simply fake numbers for no reason at all. this really should be fixed... 02/28/21
room_string = string_delete(room_string, 1, 4)



//get the string grid
var room_grid = map[? "room_grid"]
//show_debug_message("about to for loop 1")
//show_debug_message("height = "+string(height))
//scroll across the top line of the top chunks
for(var chunk_x = 0; chunk_x < width; chunk_x++){
    for(var row = 0; row < room_cells; row++){
        for(var chunk_y = 0; chunk_y < height; chunk_y++){
            
            room_grid[# _x+chunk_x, _y+chunk_y] += string_copy(room_string, 1, room_cells*4)
            //show_debug_message("room_grid[# "+string(_x+chunk_x)+", "+string(_y+chunk_y)+"] = "+room_grid[# _x+chunk_x, _y+chunk_y])
            room_string = string_delete(room_string, 1, room_cells*4)
        }
    }
}



//set the rooms to be connecting if they are
var up    = 1 // up    = 0001
var right = 2 // right = 0010
var down  = 4 //down   = 0100
var left  = 8 // left  = 1000

var room_connections_grid = map[? "room_connections_grid"]

for(var chunk_x = 0; chunk_x < width; chunk_x++){
    for(var chunk_y = 0; chunk_y < height; chunk_y++){
        //up
        if (chunk_y > 0) room_connections_grid[# _x+chunk_x, _y+chunk_y] += up
        //right
        if (chunk_x < width-1) room_connections_grid[# _x+chunk_x, _y+chunk_y] += right
        //down
        if (chunk_y < height-1) room_connections_grid[# _x+chunk_x, _y+chunk_y] += down
        //left
        if (chunk_x > 0) room_connections_grid[# _x+chunk_x, _y+chunk_y] += left
    }
}

return true;
