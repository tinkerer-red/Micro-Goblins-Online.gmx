///draw_cone(x,y,direction,lenght,angle,vertices,outline)
//
//
//vertices = The cone is made of several triangles, this is how many triangles will be drawn to achiev the effect, the bigger the number of "triangles", the more detailed the cone will be, 12 is a good start value
//outline = Well, this is if you want to draw the outline only, or the whole shape, just like the draw_rectangle function.

draw_set_color(c_black)
var xx=argument0,yy=argument1,dir=argument2-(argument4/2),lng=argument3,ang=argument4,steps=argument5;
var pr=pr_trianglefan;
if (argument6) {pr=pr_linestrip}
draw_primitive_begin(pr);
draw_vertex(xx,yy);
for(i=0; i<=steps; i++)
   {
       draw_vertex(xx+lengthdir_x(lng,dir+(ang*i/steps)),yy+lengthdir_y(lng,dir+(ang*i/steps)));
   }
if (argument6) {draw_vertex(xx,yy);}
draw_primitive_end();

draw_set_colour(c_white)
var t = degtorad(ang)  //theta is meassured in radians
var R = lng
var dir = argument2

var r = R * (sin(t/2) / (1 + sin(t/2)))

var center_x = xx+lengthdir_x(R-r, dir)
var center_y = yy+lengthdir_y(R-r, dir)

draw_circle(center_x, center_y, r, 0)

