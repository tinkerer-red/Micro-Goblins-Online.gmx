///   collision_cone_list(x, y, direction, length, angle, obj, prec, notme);
//  
//  Returns: ds_list
//  
//  x         - the x point of the cone
//  y         - the y point of the cone
//  direction - direction from x,y of the cone expands from
//  length    - the total distance the cone reaches, similar to the radius of a circle
//  angle     - The angle width of the cone
//  prec      - Whether the check is based on pixel-perfect collisions (true = slow) or its bounding box in general (false = fast). 
//  obj       - The object to check for instance collisions.
//  notme     - Whether the calling instance, if relevant, should be excluded (true) or not (false). 
//  
/// GMLscripts.com/license

///NOTE: make sure to have an object named o_sensor in your project, or below change the variable to what ever you wish.

var xx = argument0
var yy = argument1
var cone_direction = argument2
var cone_radius = argument3
var cone_angle = argument4
var object = argument5
var prec = argument6
var notme = argument7


///change this variable to what ever you would like the sensor object to be.
var sensor_object_index = o_sensor


if (notme){
  var notme_id = id;
}else{
  var notme_id = -1
}


//  Create Collision Mask, 1x2 pixel rectangle
if !variable_global_exists("collision_cone_list_sprite")
{
  var surf = surface_create(1,2);
  surface_set_target(surf);
  draw_clear_alpha(c_white, 1);
  surface_reset_target();
  global.collision_cone_list_sprite = sprite_create_from_surface(surf, 0, 0, 1, 2, false, false, 1, 1);
  sprite_collision_mask(global.collision_cone_list_sprite, false, 0, 0, 0, 0, 1, 1, 0);
  surface_free(surf);
}

//assign the sensor object
if (prec || (cone_angle >= 180))
{
  if instance_exists(sensor_object_index){
    var sensor = instance_nearest(xx,yy,sensor_object_index);
  }else{
    var sensor = instance_create(xx,yy,sensor_object_index);
    // Set Collision Mask
    sensor.sprite_index = global.collision_cone_list_sprite;
    sensor.mask_index = global.collision_cone_list_sprite;
  }
  sensor.image_xscale = cone_radius;
  sensor.image_yscale = cone_radius;
}


if (cone_angle < 180)  // calculate the points of the triangle check
{  //if the angle is larger then 179.9 this would hinder us
  var angled_length = cone_radius/sin(degtorad(90-cone_angle/2))*sin(degtorad(90));
  var x2 = x+lengthdir_x(angled_length,cone_direction-cone_angle/2);
  var y2 = y+lengthdir_y(angled_length,cone_direction-cone_angle/2);
  var x3 = x+lengthdir_x(angled_length,cone_direction+cone_angle/2);
  var y3 = y+lengthdir_y(angled_length,cone_direction+cone_angle/2);
}


//create the list to return
var list = ds_list_create()


with (object) {
  //  Circle Check
  if (collision_circle(xx, yy, cone_radius, id, prec, false)) && (notme_id != id)
  {
    //Triangle Check
    if (cone_angle >= 180) || (rectangle_in_triangle(bbox_left,bbox_top,bbox_right,bbox_bottom, xx,yy,x2,y2,x3,y3) > 0)
    {
      if prec || (cone_angle >= 180)
      {
          if (cone_angle <= 180){
            //  Plane Check 1
            sensor.image_angle = cone_direction - cone_angle/2 -90;
            if (place_meeting(x, y, sensor.id)){
              //  Plane Check 2
              sensor.image_angle = cone_direction + cone_angle/2 +90;
              if (place_meeting(x, y, sensor.id)){
                // Finalize
                ds_list_add(list, id);
              }
            }
            
          }else{  //  if the angle is larger then 180
            var include = false;
            if (cone_angle >= 360){
              //if angle is 360 just add everything in the circle
              var include = true;
            }else{
              //  Plane Check 1
              sensor.image_angle = cone_direction - cone_angle/2 -90;
              if (place_meeting(x, y, sensor.id)) var include = true;
              //  Plane Check 2
              sensor.image_angle = cone_direction + cone_angle/2 +90;
              if (place_meeting(x, y, sensor.id)) var include = true;
            }
            //  Finalize
            if (include) ds_list_add(list, id);
          }
      }else{ //if prec = false
        ds_list_add(list, id)
      }
    }
  }
}
if (instance_exists(sensor_object_index)) instance_destroy(sensor);
return list
