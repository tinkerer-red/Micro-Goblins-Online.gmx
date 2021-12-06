///draw_item(map_id, x, y, width, height)

/// This is a draw function and will only work in the draw event, or when using a surface

var map = argument0,
    xx  = argument1,
    yy  = argument2,
    width = argument3,
    height = argument4;

if !is_undefined(map)
&& ds_exists(map, ds_type_map){
  var spr = map[? "sprite"];
  //make sure the sprite exists incase someone tried to edit the save file
  if !is_undefined(spr)
  && sprite_exists(spr){
    var hue = map[? "hue"];
    
    //incase someone removed the hue value from the save file
    if is_undefined(hue){hue = 0}
    
    //init the hue shifting shader
    shader_set_hue(hue)
    draw_sprite_stretched(spr, 0, xx, yy, width, height)
    shader_reset()
  }
}

