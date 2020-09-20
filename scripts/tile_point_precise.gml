///@description tile_point_precise(x,y,layer)
///@param x
///@param y
///@param layer

var _layer = argument2;

_checker = obj_precise_tile_checker;
if(!instance_exists(_checker)) instance_create(0,0,_checker); 

var _x = argument0,
    _y = argument1;

var _tile = tile_layer_find(_layer, _x, _y);
if(_tile){
  var bg = tile_get_background(_tile),
      bg_ww = background_get_width(bg),
      ww = tile_get_width(_tile),
      hh = tile_get_height(_tile),
      ll = (tile_get_left(_tile) / ww),
      tt = (tile_get_top(_tile) / hh);
  
  var pos = ll + tt*(bg_ww div ww);
  
  if(pos == 0) return true;
  
 _checker.x = _x - (_x mod tile_get_width(_tile));
 _checker.y = _y - (_y mod tile_get_height(_tile));
 _checker.image_index = pos;
  
 
 if(collision_point(argument0,argument1,_checker, true, true)) return true;
}

return false;

