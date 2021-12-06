///scr_draw_9slices_ext(sprite, subimage, x1, y1, x2, y2, color, alpha[, scale]);

// Written by Heartbeast. https://www.youtube.com/watch?v=GkH5CIamSyA
// modified by CB for color, alpha and subimage arguments
// modified by Red for scaling argument

///@param sprite
///@param subimage
///@param x1
///@param y1
///@param x2
///@param y2
///@param c
///@param a
///@param [scale]

var sprite = argument[0];
var simg   = argument[1];
var x1 = argument[2];
var y1 = argument[3];
var x2 = argument[4];
var y2 = argument[5];
var c  = argument[6];
var a  = argument[7];

if (argument_count = 9){
  var uv_scale = argument[8];
}else{
  var uv_scale = 1;
}

var slice_width  = sprite_get_width(sprite) / 3;
var slice_height = sprite_get_height(sprite) / 3;

if (sprite_get_width(sprite) % 3 != 0 || sprite_get_height(sprite) % 3 != 0) {
    show_debug_message("WARNING: Sprite is not a multiple of 3.");
}

var width = abs(x2-x1);
var height = abs(y2-y1);

// Top
draw_sprite_part_ext(sprite, simg, 0, 0, slice_width, slice_height, x1, y1, uv_scale, uv_scale, c, a); // Left
draw_sprite_part_ext(sprite, simg, slice_width, 0, slice_width, slice_height, x1+slice_width*uv_scale, y1, (width-slice_width*uv_scale*2)/slice_width, uv_scale, c, a); // Middle
draw_sprite_part_ext(sprite, simg, slice_width*2, 0, slice_width, slice_height, x2-slice_width*uv_scale, y1, uv_scale, uv_scale, c, a); // Right

// Middle
draw_sprite_part_ext(sprite, simg, 0, slice_height, slice_width, slice_height, x1, y1+slice_height*uv_scale, uv_scale, (height-slice_height*uv_scale*2)/slice_height, c, a); // Left
draw_sprite_part_ext(sprite, simg, slice_width, slice_height, slice_width, slice_height, x1+slice_width*uv_scale, y1+slice_height*uv_scale, (width-slice_width*uv_scale*2)/slice_width, (height-slice_height*uv_scale*2)/slice_height, c, a); // Middle
draw_sprite_part_ext(sprite, simg, slice_width*2, slice_height, slice_width, slice_height, x2-slice_width*uv_scale, y1+slice_height*uv_scale, uv_scale, (height-slice_height*uv_scale*2)/slice_height, c, a); // Right

// Bottom
draw_sprite_part_ext(sprite, simg, 0, slice_height*2, slice_width, slice_height*2, x1, y2-slice_height*uv_scale, uv_scale, uv_scale, c, a); // Left
draw_sprite_part_ext(sprite, simg, slice_width, slice_height*2, slice_width, slice_height, x1+slice_width*uv_scale, y2-slice_height*uv_scale, (width-slice_width*uv_scale*2)/slice_width, uv_scale, c, a); // Middle
draw_sprite_part_ext(sprite, simg, slice_width*2, slice_height*2, slice_width, slice_height, x2-slice_width*uv_scale, y2-slice_height*uv_scale, uv_scale, uv_scale, c, a); // Right
