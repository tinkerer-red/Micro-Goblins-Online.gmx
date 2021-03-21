///draw_arcLightning()

var sprite = spr_lightning;
var particle = prt_sparkle;
var width = w_hype - 4;

arc_frame += sprite_get_number(spr_lightning)/(room_speed*0.33)
if arc_frame >= sprite_get_number(spr_lightning){
  arc_frame = arc_frame mod sprite_get_number(spr_lightning)
}
//show_debug_player(arc_frame)
//show_debug_player("sprite_get_number(arc_frame) = "+string(sprite_get_number(spr_lightning)))
//var pathIndex = argument[0]

/*
//////////primitive
texture_set_repeat(true)
draw_set_color(c_white)
quality =  path_get_number(pathIndex)*4
q = 1 / quality

//if (argument_count >= 2){
//  width = argument[1]/2
//}else{
//  width = sprite_get_width(sprite)/2
//}

length = path_get_length(pathIndex)

oldX = path_get_point_x(pathIndex, 0)
oldY = path_get_point_y(pathIndex, 0)

newX = path_get_x(pathIndex, 0)
newY = path_get_y(pathIndex, 0)

draw_primitive_begin_texture(pr_trianglestrip, sprite_get_texture(sprite, 0))
for (i = q; i <= 1; i += q)
{
    nextX = path_get_x(pathIndex, min(i + q, 1))
    nextY = path_get_y(pathIndex, min(i + q, 1))
    
    //Divide [dx, dy] by its own length to turn it into a unit vector (a vector with length 1)
    d = point_distance(nextX, nextY, oldX, oldY)
    dx = (nextX - oldX) / d
    dy = (nextY - oldY) / d
    oldX = newX
    oldY = newY
    newX = nextX
    newY = nextY
    
    //[dx, dy] is parallell to the path. This means that [dy, -dx] is perpendicular to the path
    draw_vertex_texture(oldX + dy * width, oldY - dx * width, i * length / width, 0)
    draw_vertex_texture(oldX - dy * width, oldY + dx * width, i * length / width, 1)
    /*
    draw_particle_line(particle,
                   oldX+dx, //x1
                   oldY+dy, //y1
                   newX, //x1
                   newY) //y1
    */
//}
//draw_primitive_end()
//////////


//////////draw last line

var arc_count = array_length_1d(mod_arcLightning_partner_array)
for (var i = 0; i < arc_count; i++){
  var target = mod_arcLightning_partner_array[i]
  if instance_exists(target){
    var xx = target.x
    var yy = target.y
    
    if (point_distance(xx, yy, x, y) < 16*8){
    
    draw_set_color(c_aqua)
    draw_sprite_line_shader(sprite, 
                      arc_frame,
                      xx, //x1
                      yy, //y1
                      x, //x2
                      y, //y2
                      width)
    draw_set_color(c_white)
    }
  }
}


//////////
//*/

//////////draw particles
/*
for (var i = 0; i < last_point; i++){
  draw_particle_line(particle,
                     path_get_point_x(pathIndex, i), //x1
                     path_get_point_y(pathIndex, i), //y1
                     path_get_point_x(pathIndex, i+1), //x1
                     path_get_point_y(pathIndex, i+1)) //y1
}

draw_particle_line(particle,
                   path_get_point_x(pathIndex, last_point), //x1
                   path_get_point_y(pathIndex, last_point), //y1
                   x, //x2
                   y) //y2
/*
//////////
