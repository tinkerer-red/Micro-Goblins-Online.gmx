///xy_to_chunk(x, y)

var xx = argument0;
var yy = argument1;
var array;

array[0] = floor( xx / global.chunk_handler.chunk_width )
array[1] = floor( yy / global.chunk_handler.chunk_height )

return array;
