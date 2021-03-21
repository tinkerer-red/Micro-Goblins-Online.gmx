///generate_dungeon_rooms_grid_remove_surrounding_rooms(room_string, room_x, room_y, size, room_list)

// room_string = the full, unspliced version of the room data, including the header which holds the room width and height
// room_x      = the x location in the dungeon where the room will spawn, (upper left side)
// room_y      = the y location in the dungeon where the room will spawn, (upper left side)
// size        = the size of the dungeon (1-4)
// room_list   = the ds_list where valid rooms are still stored 


/*
this code is just here to simplify the removal of illegal rooms from the list,
For instance when the boss room is spawned, we cant have a treasure room spawning
connecting to it. So we store a list of all valid rooms, and when ever we gen
a room we make sure the room isnt reaching into an illegal room.

This script simple finds the size of the room, removes all the rooms it's taking
up. and then also removes all of the edge rooms which are connected.
*/

var room_string = argument0   // the full, unspliced version of the room data, including the header which holds the room width and height
var room_x      = argument1   // the x location in the dungeon where the room will spawn, (upper left side)
var room_y      = argument2   // the y location in the dungeon where the room will spawn, (upper left side)
var size        = argument3   // the size of the dungeon (1-4)
var room_list   = argument4   // the ds_list where valid rooms are still stored 

//the dungeon's width and height
var width = size*4 -1  //rooms cells wide
var height = size*4 -1 //room cells tall

//the room's width and height in string form
var rw  = string_copy(room_string, 1, 2)
var rh = string_copy(room_string, 3, 2)

//the room's width and height in real values
var room_w = hex_to_dec(rw)
var room_h = hex_to_dec(rh)

//cycle through the entire zone
for (var xx = room_x-1; xx <= room_x+room_w; xx++){
  for (var yy = room_y-1; yy <= room_y+room_h; yy++){
    //make sure we're in bounds
    if (xx <0)
    || (yy <0)
    || (xx >= width)
    || (xx >= height)
    {continue;}
    
    //skip over the corners
    if ((xx=room_x-1)&&(yy=room_y-1))
    || ((xx=room_x+room_w)&&(yy=room_y-1))
    || ((xx=room_x-1)&&(yy=room_y+room_h))
    || ((xx=room_x+room_w)&&(yy=room_y+room_h))
    {continue;}
    
    //check to make sure the ds_list even has the value still
    var value = xx + (yy*width)
    var pos = ds_list_find_index(room_list, value)
    if (pos = -1) {continue;}
    
    //if everything checks out then remove the value from the list
    ds_list_delete(room_list, pos)
  }
}
