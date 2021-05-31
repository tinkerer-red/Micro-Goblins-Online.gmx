///scr_spawn_entity_create(x, y, [SubType])

var xx = argument[0]
var yy = argument[1]

if (argument_count = 3) {
  var sub_type = argument[2]
}else{
  //this value is between 0-1, we'll use this in the future to figure out which SubType to create.
  var normalized_seed = seed_interior_location(xx, yy)
  var sub_type_array;
  sub_type_array[0] = "normal"
}
