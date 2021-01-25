///is_interior(x, y)

//returns true or false

var xx = argument0
var yy = argument1

//its faster to find out if one of these are true then it is to find out if all of them are true, which is why we check for interiors then exteriors
if (xx > global.chunk_handler.world_width)
|| (xx < 0)
|| (yy > global.chunk_handler.world_height)
|| (yy < 0){
    return true;
}else{
    return false;
}

