/// scr_collision_test

if !variable_instance_exists(self.id, "stuck_i") stuck_i = 0;

if place_free(x,y)
{ stuck_i =0 } else { stuck_i++ }

if (stuck_i = 3) instance_destroy();

var xx = x+lengthdir_x(speed,direction)
var yy = y+lengthdir_y(speed,direction)

if !place_free(xx,yy)
{
  //var hype = sqrt(power(sprite_width,2)+power(sprite_height,2))
  
  //var dir = collision_normal(xx, yy, obj_solid, self.sprite_width, 1)
  var dir = collision_normal_circle(x,y,sprite_height*1.25,sprite_height*1.25/21,false);
  
  array[0] = speed
  array[1] = direction + (angle_difference(dir, direction)-90)*2
  
  var xx = x+lengthdir_x(array[0],array[1]);
  var yy = y+lengthdir_y(array[0],array[1]);
  
}else{
  array[0] = speed
  array[1] = direction
}
return array;
