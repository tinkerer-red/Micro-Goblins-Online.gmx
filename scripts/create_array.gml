/// create_array(val1, val2, ...)

var _arr = array_create(argument_count);
var _i = 0; repeat (argument_count) {
  _arr[_i] = argument[_i];
  ++_i;
}
return _arr;
