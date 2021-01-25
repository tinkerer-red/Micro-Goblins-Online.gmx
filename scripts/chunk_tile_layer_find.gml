///chunk_tile_layer_find(chunk_id, layer, chunk_x, chunk_y)


/*
Layer Types
  layer_heightmap  = 
  layer_structures = 
  layer_obsticals  = 
*/

var chunk_id = argument0
var chunk_x = argument2
var chunk_y = argument3



//define which grid we're going to use to check
var _layer = argument1;
switch (_layer){
  case "layer_heightmap":
    var grid_string = "heightmap_grid"
  break;
  case "layer_structures":
    var grid_string = "structure_grid"
  break;
  case "layer_obsticals":
    var grid_string = "obsticals_grid"
  break;
}

//grab the chunk's requested grid
if variable_instance_exists(chunk_id, grid_string){
  var grid = variable_instance_get(chunk_id, grid_string);
}else{
  return false
}
return grid[# chunk_x, chunk_y]
