///draw_airStrike()

var max_dist = 1024;
var wave_length = sin((pi/(w_range)) * dis_traveled)

if (dis_traveled >= (w_range/2)){
  var xx = mod_airstrike_end_point_x
  var yy = mod_airstrike_end_point_y-(abs(wave_length)*max_dist);
  var rot = 270-45
}else{
  var xx = x
  if (sign(wave_length)=1){
    var yy = y-(abs(wave_length)*max_dist);
  }else{
    var yy = y
  }
  var rot = 90-45
}

var blend = 1-wave_length

//actually draw the sprite
draw_sprite_ext(sprite_index, image_index, xx, yy, image_xscale, image_yscale, rot, c_white, blend)
