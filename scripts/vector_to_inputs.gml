///vector_to_inputs(xx, yy [, distance_clamp])

var xx = argument[0]
var yy  = argument[1]

var _dist = point_distance(0,0,xx,yy)

if (argument_count = 3){
  var _clamp = argument[2]
  if (_dist > _clamp){
    _dist = _clamp
  }
}


//temp values
var t_up = abs(min(yy, 0));
var t_down = max(yy, 0);
var t_left = abs(min(xx, 0));
var t_right = max(xx, 0);


//actually apply the inputs
up += _dist*t_up
down += _dist*t_down
left += _dist*t_left
right += _dist*t_right
