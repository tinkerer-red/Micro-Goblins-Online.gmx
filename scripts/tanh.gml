///tanh(x)
//
//Hyperbolic tangent

var _x = argument0;
var _e = 2.718281828459;

// if the input is an array
if is_array(_x){
  var _ans = 0
  ///for each cell in the final array
  for (var i = 0; i < array_length_2d(_x,0); i++){
    for (var j = 0; j < array_height_2d(_x); j++){
      // initialize the cell
      _ans[j,i] = (power(_e, 2*_x[j,i])-1)/(power(_e, 2*_x[j,i])+1); //a1[j,i] * r;
    }
  }
  return(_ans);
}

// if the input is a real value
if is_real(_x){
  var _ans = (power(_e, 2*_x)-1)/(power(_e, 2*_x)+1);
  return(_ans);
}




