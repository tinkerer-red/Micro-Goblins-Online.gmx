///chunk_interior_exists(chunk_x, chunk_y)

var array = interior_chunk_find_grid_pos(argument0, argument1)
if (array = undefined){
  //chunk_uncall_forced()
  return false;
}
var grid_x = array[0]
var grid_y = array[1]
var map = array[2]

var chunk_id_grid = map[? "chunk_id_grid"]
if (chunk_id_grid[# grid_x, grid_y] = noone){
  return false;
}else{
  return true
}


return false;
