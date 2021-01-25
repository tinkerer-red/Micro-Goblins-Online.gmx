// instance_nearest_notme(x, y, obj);

var x1, y1, obj, _sign;
x1 = argument0;
y1 = argument1;
obj = argument2;
_sign = sign(x1)

var _x = x;
x -= _sign*10000000;
var _inst = instance_nearest(x1, y1, obj);
x = _x;

if (_inst != id){
  // You found an instance!
  return _inst;
}
return noone;
