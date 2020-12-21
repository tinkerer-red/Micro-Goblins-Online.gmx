///draw_sprite_pathed(sprite, path, [width])

var sprite = argument[0]
var pathIndex = argument[1]

texture_set_repeat(true)
draw_set_color(c_white)
quality =  path_get_number(pathIndex)*4
q = 1 / quality

if (argument_count >= 3){
  width = argument[2]/2
}else{
  width = sprite_get_width(sprite)/2
}

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
    
}
draw_primitive_end()
