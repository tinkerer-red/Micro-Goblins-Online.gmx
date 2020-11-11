///chunk_uncall_region(world_x, world_y)


var xx = argument0;
var yy = argument1;

var reach = chunk_dist+margin

if (sign(xx) = -1) {var x_sign = -1} else {var x_sign = 0}
if (sign(yy) = -1) {var y_sign = -1} else {var y_sign = 0}

var cell_x = (xx div chunk_width) + x_sign
var cell_y = (yy div chunk_height) + y_sign
//*
for (var i = -reach; i <= reach; i++){
  for (var j = -reach; j <= reach; j++){
    chunk_uncall(cell_x+i, cell_y+j)
  }
}
//*/

/*
//Spiral
    var _x, _y, dx, dy;
    _x = 0;
    _y = 0;
    dx = 0;
    var dy = -1;
    var t = max(cell_x, cell_y);
    var maxI = t*t;
    for(var i =0; i < maxI; i++){
        if ((-chunk_dist <= _x) && (_x <= chunk_dist) && (-chunk_dist <= _y) && (_y <= chunk_dist)){
            // DO STUFF...
            chunk_uncall(cell_x+_x, cell_y+_y)
//            show_debug_message("uncall: "+string(cell_x+_x)+","+string(cell_y+_y))
        }
        if( (_x == _y) || ((_x < 0) && (_x == -_y)) || ((_x > 0) && (_x == 1-_y))){
            t = dx;
            dx = -dy;
            dy = t;
        }
        _x += dx;
        _y += dy;
        if (_x > reach) && (_y > reach){
          break;
        }
    }




