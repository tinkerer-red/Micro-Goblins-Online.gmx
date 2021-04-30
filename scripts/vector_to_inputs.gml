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

//actually apply the inputs
up += abs(sign(min(yy, 0))*_dist)
down += sign(max(yy, 0))*_dist
left += abs(sign(min(xx, 0))*_dist)
right += sign(max(xx, 0))*_dist
