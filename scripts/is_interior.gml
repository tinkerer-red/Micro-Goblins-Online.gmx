///is_interior(x, y)

//returns true or false
if (argument_count = 2){
  var xx = argument[0]
  var yy = argument[1]
}else{
  var xx = x
  var yy = y
}

//its faster to find out if one of these are true then it is to find out if all of them are true, which is why we check for interiors then exteriors
if (xx > global.chunk_handler.world_width-1)
|| (xx < 0)
|| (yy > global.chunk_handler.world_height-1)
|| (yy < 0){
    return true;
}else{
    return false;
}

