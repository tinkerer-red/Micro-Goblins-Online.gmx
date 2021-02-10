///draw_sprite_explode(sprite)

var max_life = room_speed/3
var min_life = room_speed/8
var max_speed = 24/max_life
var min_speed = 16/min_life
var max_peice_size = 6*image_xscale
var min_peice_size = 2*image_xscale
var spin = 0 //5 * (60/room_speed)
var fade = 1
var fade_amt = 1/min_life
var fade_to_color = c_white
var end_color_display = c_white
var color_fade_speed = 0
var implode = false

scr_sprite_explode(max_life, 
                   min_life, 
                   max_speed, 
                   min_speed, 
                   max_peice_size, 
                   min_peice_size, 
                   spin, 
                   fade, 
                   fade_amt, 
                   fade_to_color, 
                   end_color_display, 
                   color_fade_speed, 
                   implode,
                   argument0);

