///   collision_cone_list_test2(x, y, direction, length, angle, obj, prec, notme);
//  
//  Returns: ds_list
//
//  Make sure to delete the list afterwards
//  
//  x         - the x point of the cone
//  y         - the y point of the cone
//  direction - direction from x,y of the cone expands from
//  length    - the total distance the cone reaches, similar to the radius of a circle
//  angle     - The width of the cone
//  prec      - Whether the check is based on pixel-perfect collisions (true = slow) or its bounding box in general (false = fast). 
//  obj       - The object to check for instance collisions.
//  notme     - Whether the calling instance, if relevant, should be excluded (true) or not (false). 
//
/// GMLscripts.com/license

var xx=argument0,yy=argument1,dir=argument2,lng=argument3,ang=argument4, object = argument5, prec = argument6, notme = argument7;

var collision_list = ds_list_create()
with (object)
{
  var ox = id.bbox_left+(id.bbox_right-id.bbox_left)
  var oy = id.bbox_top+(id.bbox_bottom-id.bbox_top)
  
  var odir = point_direction(xx, yy, ox, oy)
  var odis = point_distance(xx, yy, ox, oy)
  if (abs(angle_difference(dir, odir)) <= ang/2) && (odis <= lng)
  {
    ds_list_add(collision_list, id)
    //test_obj.x += 1000000
  }
  
}

return collision_list



