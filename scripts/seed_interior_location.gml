///seed_interior_location(x, y)

var xx = argument[0];
var yy = argument[1];

var chunk_array = xy_to_chunk(xx, yy);

var ext_array = interior_chunk_find_exterior_chunk_pos(chunk_array[0], chunk_array[1]);
var grid_array = interior_chunk_find_grid_pos(chunk_array[0], chunk_array[1], ext_array[2]);

var _x = xx mod one_chunk;
var _y = yy mod one_chunk;

_x = grid_array[0] * one_chunk;
_y = grid_array[1] * one_chunk;

_x += ext_array[0] * one_chunk * global.chunk_handler.world_chunk_width;
_y += ext_array[1] * one_chunk * global.chunk_handler.world_chunk_height;

return scr_noise_2dig(_x, _y);

