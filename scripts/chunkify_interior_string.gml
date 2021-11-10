///chunkify_interior_string(x1, y1, string, interior_map, valid_room_list, size, is_hall)

var _x = argument[0];
var _y = argument[1];
var room_string = argument[2];
var map = argument[3];
var room_list = argument[4];
var size = argument[5];


if (argument_count = 7){
  var is_hall = argument[6]; //this value allows for a room to be generated over important room neighbors which were removed from valid room list
}else{
  var is_hall = false;
}
var dung_width = size*4 -1
var dung_height = size*4 -1

var room_cells = global.chunk_handler.chunk_width div global.chunk_handler.tile_size


var width  = string_copy(room_string, 1, 2)
var height = string_copy(room_string, 3, 2)
room_string = string_delete(room_string, 1, 4)


var width  = hex_to_dec(width);
var height = hex_to_dec(height);

//CHECK TO MAKE SURE ALL ROOMS WILL BE EMPTY BEFORE WE WRITE
var room_grid = map[? "room_grid"]
for(var chunk_x = 0; chunk_x < width; chunk_x++){
    for(var chunk_y = 0; chunk_y < height; chunk_y++){
        
        if (_x+chunk_x < 0) || (_x+chunk_x > dung_width){
          return false;}
        if (_y+chunk_y < 0) || (_y+chunk_y > dung_height){
          return false;}
        if (room_grid[# _x+chunk_x, _y+chunk_y] != ""){
          return false;}
        
        if (is_hall = false){
          //check to make sure the ds_list even has the value still
          var value = (_x+chunk_x) + ((_y+chunk_y)*(dung_width+1))
          var pos = ds_list_find_index(room_list, value)
          if (pos = -1) {
            return false;
          }
        }
    }
}

//delete the doors variable because why would we need them? fuck em
//What the fuck was red on about when he added this? it doesnt do anything, it's simply fake numbers for no reason at all. this really should be fixed... 02/28/21
room_string = string_delete(room_string, 1, 4)



//get the string grid
var room_grid = map[? "room_grid"]
//scroll across the top line of the top chunks
for(var chunk_x = 0; chunk_x < width; chunk_x++){
    for(var row = 0; row < room_cells; row++){
        for(var chunk_y = 0; chunk_y < height; chunk_y++){
            room_grid[# _x+chunk_x, _y+chunk_y] += string_copy(room_string, 1, room_cells*4)
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
