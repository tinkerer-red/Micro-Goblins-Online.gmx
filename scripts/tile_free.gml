///@description tile_free(x,y,layer)
///@param x
///@param y
///@param layer



var _x = argument0,
    _y = argument1,
    _layer = argument2;
    
if !tile_layer_find(_layer, _x, _y) return true;

return false;

