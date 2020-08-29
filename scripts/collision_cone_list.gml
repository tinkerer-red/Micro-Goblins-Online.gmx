///   collision_cone_list(x, y, direction, length, angle, vertices, obj)
//  
//  Returns: ds_list
//
//  Make sure to have an object named o_sensor in the project
//    because object_add() is obsolete.
//  
//  x         - the x point of the cone
//  y         - the y point of the cone
//  direction - direction from x,y of the cone expands from
//  length    - the total distance the cone reaches, similar to the radius of a circle
//  angle     - The width of the cone
//  vertices  - The cone is made of several triangles, this is how many triangles will be drawn to achieve the effect, the bigger the number of "triangles", the more detailed the cone will be, 12 is a good start value
//                   0 will auto calculate.
//  obj       - The object to detect collision with.
//  
/// GMLscripts.com/license

var xx=0,yy=0,dir=argument2-(argument4/2),lng=argument3,ang=argument4,steps=argument5, prmitive_array;

if (steps = 0) {steps = ang/15} //3 triangles per 45 degrees

//calculate how big the cone will be
var surf_left   = 0;
var surf_right  = 0;
var surf_top    = 0;
var surf_bottom = 0;

prmitive_array[0,0] = 0;
prmitive_array[0,1] = 0;

for(i=0; i<=steps; i++)
{
  var _xx = xx+lengthdir_x(lng,dir+(ang*i/steps));
  var _yy = yy+lengthdir_y(lng,dir+(ang*i/steps));
  
  prmitive_array[i+1,0] = _xx
  prmitive_array[i+1,1] = _yy
  
  var surf_left   = min(surf_left, _xx)
  var surf_right  = max(surf_right, _xx)
  var surf_top    = min(surf_top, _yy)
  var surf_bottom = max(surf_bottom, _yy)
}

x_off = abs(surf_left)
y_off = abs(surf_top)


//once the cone's size is calculated and then vertex's are ready to be drawn
//make the surface
var surf_col = surface_create(round(surf_right - surf_left), round(surf_bottom - surf_top))
surface_set_target(surf_col)


///once the surface is created, actually start work on drawing the primitive
var pr=pr_trianglefan;
draw_primitive_begin(pr);

draw_vertex(prmitive_array[0,0]+x_off, prmitive_array[0,1]+y_off);
       
for(i=0; i<=steps; i++)
{
  var _xx = prmitive_array[i+1,0]+x_off
  var _yy = prmitive_array[i+1,1]+y_off
  
  draw_vertex(_xx,_yy);
}

draw_primitive_end();
surface_reset_target();

// create the sprite
var spr = sprite_create_from_surface(surf_col, 0, 0, round(surf_right - surf_left), round(surf_bottom - surf_top), 0, 0, x_off, y_off);
sprite_collision_mask(spr, 0, 1, 0, 0, 0, 0, 0, 0);
//free the surface
surface_free(surf_col);


//create the object and apply variables
var col_sensor = instance_create(argument0,argument1,o_sensor)

var object = argument6

with col_sensor
{
  sprite_index = spr
  var collision_list = ds_list_create()
  
  //cycle through all of the collided objed deactivating them
  while (place_meeting(x, y, object))
  {
    var obj_col = instance_place(x,y, object)
    ds_list_add(collision_list, obj_col)
    instance_deactivate_object(obj_col)
  }
  
  //when finished re activate all collided object in list
  if not ds_list_empty(collision_list)
  {
    for (var i = ds_list_size(collision_list)-1; i >= 0; i--)
    {
      instance_activate_object(collision_list[| i])
    }
  }
}

//sprite_delete(spr)
//instance_destroy(col_sensor)


return collision_list



