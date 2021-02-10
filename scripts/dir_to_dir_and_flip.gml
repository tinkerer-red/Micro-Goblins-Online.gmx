/// dir_to_dir_and_flip(direction)

/*returns:
          array[0] = direction (0-90 or 180-360)
          array[1] = flip (-1 or 1)
*/


var _dir = argument0
var array;

if (_dir > 90) && (_dir < 270){
  
  if (_dir <= 180){  //if we're in section 2
    var ang = angle_difference(90, _dir);
    array[0] = 90 - ang
    array[1] = -1
    return array;
  }
  
  if (_dir > 180){  //if we're in section 3
    var ang = angle_difference(270, _dir);
    array[0] = 270 - ang
    array[1] = -1
    return array;
  }
  
  
}else{
  array[0] = _dir
  array[1] = 1
  return array;
}
