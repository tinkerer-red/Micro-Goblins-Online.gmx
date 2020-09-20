///@description tile_meeting_precise(x,y,layer)
///@param x
///@param y
///@param layer

var _layer = argument2;

_checker = obj_precise_tile_checker;
if(!instance_exists(_checker)) instance_create(0,0,_checker); 

var _x1 = bbox_left + (argument0 - x),
    _y1 = bbox_top + (argument1 - y),
    _x2 = bbox_right + (argument0 - x),
    _y2 = bbox_bottom + (argument1 - y),
    
for(var _x = _x1; _x <= _x2; _x++){
  for(var _y = _y1; _y <= _y2; _y++){
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

     if(place_meeting(argument0,argument1,_checker)) return true;
    }
 }
}

return false;

