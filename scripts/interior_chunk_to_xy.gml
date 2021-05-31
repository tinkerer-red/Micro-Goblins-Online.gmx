///interior_chunk_to_xy(zone_pos, cell_x, cell_y)

/*
This script returns the real word coordinates of the interior's cell possition
returns: array[0] = xx
         array[1] = yy
*/

var zone_pos = argument0
var cell_x = argument1
var cell_y = argument2


var zones_per_col = global.chunk_handler.world_chunk_height div global.chunk_handler.interior_zone_size

var zone_x = zone_pos div zones_per_col
var zone_y = zone_pos mod zones_per_col


var xx = (zone_x*(global.chunk_handler.interior_zone_size*global.chunk_handler.chunk_width)) + global.chunk_handler.world_width-1;
var yy = (zone_y*(global.chunk_handler.interior_zone_size*global.chunk_handler.chunk_height));

xx += cell_x*global.chunk_handler.chunk_width
yy += cell_y*global.chunk_handler.chunk_height

var array;

array[0] = xx
array[1] = yy

return array;
