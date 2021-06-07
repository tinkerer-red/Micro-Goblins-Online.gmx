///chunk_generate_interior(chunk_x, chunk_y, size, type, interior_map)

/* TYPES
    0-Dungeon
    1-Town
    2-Final Dungeon
*/


var xx = argument0
var yy = argument1
var size = argument2  //1-4
var type = argument3
var map = argument4

if (type = 2) size = 4;

//ds_grid_create(4*size, 4*size)
//show_debug_message("chunk_generate_interior switch start")
switch(type)
{
    case 0:
        generate_dungeon_rooms_grid(xx, yy, size, map)
    break;
    case 1:
        generate_town_grid(xx, yy, size, map)
    break;
    case 2:
        //generate_dungeon_rooms_grid(xx, yy, size, map)
    break;
}
