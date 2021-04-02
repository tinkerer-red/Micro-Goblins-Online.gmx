/// collision_normal_circle(x, y, radius, resolution, prec)

// x
// y
// radius
// resolution - how many pixels of the radius to draw
// prec - (false) = outerring check only; (true) = entire circle check

var cx, cy, xx, yy, radius, res, prec, radius_i, degrees, degrees_i, rads, nx, ny;

cx = argument0
cy = argument1
xx = cx
yy = cy
radius = argument2
radius_i = radius
res = argument3
prec = argument4
degrees = 0
nx = 0
ny = 0

//draw_set_color(c_dkgray)
//draw_set_alpha(0.25)
if (res > radius*2){
  res = radius*2;
  show_debug_message("Error: resolution is larger then the circle")
}

if (collision_circle(cx, cy, radius, obj_solid, true, true)) {
  while (radius_i > 0)
  {
    //pi method
    degrees_i = (res/((radius_i*2)*pi))*360
    degrees_i =  360/round(360/degrees_i)
    
    while (degrees < 360)
    {
      rads = degtorad(degrees)
      xx = cos(rads) * radius_i
      yy = sin(rads) * radius_i 
      
      if (collision_point(cx+xx,cy+yy,obj_solid,true,false)){
        //draw_set_color(c_red);
      }else{
        //draw_set_color(c_green);
        nx += xx
        ny += yy
      }
      //draw_circle(cx+xx,cy+yy,res/2,0)
      degrees += degrees_i
    }
    degrees = 0
    radius_i -= res
    if (!prec) radius_i = 0;
  }
  //draw_set_color(c_white)
  //draw_set_alpha(1)
  if (nx == 0 && ny == 0) return (-1);
  return point_direction(0,0,nx,ny);
  
}else{
  return (-1);
}
