///interior_chunk_find_zone_pos(chunk_x, chunk_y)

var array;
var chunk_x = argument0;
var chunk_y = argument1;

var world_chunk_width = global.chunk_handler.world_width div global.chunk_handler.chunk_width
var world_chunk_height = global.chunk_handler.world_height div global.chunk_handler.chunk_height

//now find the zone
var ext_chunk_x = chunk_x - world_chunk_width
var ext_chunk_y = chunk_y

var zones_per_col = global.chunk_handler.world_chunk_height div interior_zone_size

var zone_x = ext_chunk_x div interior_zone_size
var zone_y = ext_chunk_y div interior_zone_size

var zone_pos = zone_x*zones_per_col + zone_y

return zone_pos;



