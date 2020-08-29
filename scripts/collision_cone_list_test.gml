///   collision_cone_list(x, y, direction, length, angle, obj, prec, notme);
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

var xx=argument0,yy=argument1,dir=argument2-(argument4/2),lng=argument3,ang=argument4, object = argument5, prec = argument6, notme = argument7;

//first we should remove anything we know for sure is with in the cone

//start with the two line checks
var collision_list = ds_list_create()

//check left side
var x2 = xx+lengthdir_x(lng, dir)
var y2 = yy+lengthdir_y(lng, dir)
var obj_col = collision_line( xx, yy, x2, y2, object, prec, notme)
while obj_col != noone
{
  ds_list_add(collision_list, obj_col)
  instance_deactivate_object(obj_col)
  //obj_col.x += 1000000
  //ds_list_delete(circle_list, ds_list_find_index(circle_list, obj_col))
  var obj_col = collision_line( xx, yy, x2, y2, object, prec, notme)
}
//check right side

var x2 = xx+lengthdir_x(lng, dir+ang)
var y2 = yy+lengthdir_y(lng, dir+ang)
var obj_col = collision_line( xx, yy, x2, y2, object, prec, notme)
while obj_col != noone
{
  ds_list_add(collision_list, obj_col)
  instance_deactivate_object(obj_col)
  //obj_col.x += 1000000
  //ds_list_delete(circle_list, ds_list_find_index(circle_list, obj_col))
  var obj_col = collision_line( xx, yy, x2, y2, object, prec, notme)
}

//then move onto the primary circle check, which will tell us which objects are FOR SURE with in the cone
var t = degtorad(ang)  //theta is meassured in radians
var R = lng
var d = argument2

var r = R * (sin(t/2) / (1 + sin(t/2)))

var center_x = xx+lengthdir_x(R-r, d)
var center_y = yy+lengthdir_y(R-r, d)

var obj_col = collision_circle(center_x, center_y, r, object, prec, notme)
while obj_col != noone
{
  ds_list_add(collision_list, obj_col)
  instance_deactivate_object(obj_col)
  //obj_col.x += 1000000
  //ds_list_delete(circle_list, ds_list_find_index(circle_list, obj_col))
  var obj_col = collision_circle(center_x, center_y, r, object, prec, notme)
}






//grab everything with in a radious,
//we use this method so we dont need to use any "all" commands (because larger projects, and more universally friendly)
var circle_list = ds_list_create()
var obj_col = collision_circle( xx, yy, lng, object, prec, notme)
while obj_col != noone
{
  ds_list_add(circle_list, obj_col)
  instance_deactivate_object(obj_col)
  //obj_col.x += 1000000
  
  var obj_col = collision_circle( xx, yy, lng, object, prec, notme)
}
//when finished re activate all collided object in list
if not ds_list_empty(circle_list)
{
  for (var i = ds_list_size(circle_list)-1; i >= 0; i--)
  {
    instance_activate_object(circle_list[| i])
    //circle_list[| i].x -= 1000000
  }
  
  
  ///now that we have everything with in the radius lets narrow down our selection to a rectangle encompassing the cone
  var steps = ang/15
  
  //calculate how big the rectangle will be surrounding the cone
  rect_left   = xx;
  rect_right  = xx;
  rect_top    = yy;
  rect_bottom = yy;
  
  for(i=0; i<=steps; i++)
  {
    var _xx = xx+lengthdir_x(lng,dir+(ang*i/steps));
    var _yy = yy+lengthdir_y(lng,dir+(ang*i/steps));
    
    
    rect_left   = min(rect_left, _xx)
    rect_right  = max(rect_right, _xx)
    rect_top    = min(rect_top, _yy)
    rect_bottom = max(rect_bottom, _yy)
  }
  // now collision check the rectangle comparing with circle
  var rect_list = ds_list_create()
  var rect_list_out = ds_list_create()
  var obj_col = collision_rectangle(rect_left, rect_top, rect_right, rect_bottom, object, prec, notme)
  while obj_col != noone
  {
    if (ds_list_find_index(circle_list, obj_col) != -1)
    {ds_list_add(rect_list, obj_col);}
    else
    {ds_list_add(rect_list_out, obj_col);}
    instance_deactivate_object(obj_col)
    //obj_col.x += 1000000
    
    var obj_col = collision_rectangle(rect_left, rect_top, rect_right, rect_bottom, object, prec, notme)
  }
  //reactivate anything that was in the rectangle but outside the circle
  for (var i = ds_list_size(rect_list_out)-1; i >= 0; i--)
  {
    instance_activate_object(rect_list_out[| i])
    //circle_list[| i].x -= 1000000
  }
  ds_list_destroy(rect_list_out)
  
  
  //now iterate through the rectangle list adding anyone landing with in the bounds of the angle
  while not ds_list_empty(rect_list)
  {
    var test_obj = rect_list[| 0]
    
    var ox = test_obj.bbox_left+(test_obj.bbox_right-test_obj.bbox_left)
    var oy = test_obj.bbox_top+(test_obj.bbox_bottom-test_obj.bbox_top)
    
    var odir = point_direction(xx, yy, ox, oy)
    if (abs(angle_difference(dir+(ang/2), odir)) <= ang/2)
    {
      ds_list_add(collision_list, test_obj)
      //test_obj.x += 1000000
    }else{
      //this is to prevent activating them twice
      instance_activate_object(test_obj)
    }
    
    ds_list_delete(rect_list, 0)
  }
  ds_list_destroy(rect_list)

}  //end of if objects in circle


ds_list_destroy(circle_list)





//when finished re activate all collided object in list
if not ds_list_empty(collision_list)
{
  for (var i = ds_list_size(collision_list)-1; i >= 0; i--)
  {
    instance_activate_object(collision_list[| i])
    //collision_list[| i].x -= 1000000
  }
}



return collision_list



