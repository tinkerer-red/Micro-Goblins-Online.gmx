/// collision_normal(x1,y1,obj [,rad [,res]])
//
//  Returns a 2D "surface normal" (in degrees) at a given point 
//  on or near an instance detected within a circular test area.
//  Makes approximately pi*(rad*rad)/(res*res) collision calls.
//  If no collision is found, (-1) is returned.
//
//      x1,y1       point on the surface, real
//      obj         object or instance (or all), real
//      rad         radius of test area (default 4), real
//      res         resolution of test (default 1), real
//
/// GMLscripts.com/license

///   https://www.gmlscripts.com/script/collision_normal

/// EXAMPLE CODE
//
//  var normal=collision_normal(x,y,obj_wall,16,4)
//  var diff=point_direction(0,0,hspeed,yspeed)-(normal+180);
//  var newdir=normal-diff;
//  //set direction to newdir here
//
///
{
    var xx  = argument[0];
    var yy  = argument[1];
    var obj = argument[2];
    var rad = 4;
    var res = 1;
    if (argument_count > 3) rad = argument[3];
    if (argument_count > 4) res = argument[4];
    if (rad <= 0) rad = 4;
    if (res <= 0) res = 1;
    var nx = 0;
    var ny = 0;
    
    if (collision_circle(xx, yy, rad, obj, true, true)) {
        for (var j=res; j<=rad; j+=res) {
            draw_set_color(c_dkgray)
            draw_set_alpha(0.5)
    
            for (var i=0; i<rad; i+=res) {
                if (point_distance(0, 0, i, j) <= rad) {
                    if (!collision_point(xx+i, yy+j, obj, true, true)) { nx += i; ny += j; draw_circle(xx+i,yy+j,res/2,false);}
                    if (!collision_point(xx+j, yy-i, obj, true, true)) { nx += j; ny -= i; draw_circle(xx+j,yy-i,res/2,false);}
                    if (!collision_point(xx-i, yy-j, obj, true, true)) { nx -= i; ny -= j; draw_circle(xx-i,yy-j,res/2,false);}
                    if (!collision_point(xx-j, yy+i, obj, true, true)) { nx -= j; ny += i; draw_circle(xx-j,yy+i,res/2,false);}
                }
            }
        }
        draw_set_color(c_white)
        draw_set_alpha(1)
    
        if (nx == 0 && ny == 0) return (-1);
        return point_direction(0, 0, nx, ny);
    }else{
        return (-1);
    }
}
