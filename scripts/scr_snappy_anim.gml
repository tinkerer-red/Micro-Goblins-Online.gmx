///scr_snappy_anim(percent)

/*
  Returns:
    float int A value between 0-1.2 ending on 1, used for multiplying an animations possition for a snappy feeling
*/

var perc = argument0
//var loc = floor(argument0*path_)
return path_get_y(path_snappy, perc)/100
