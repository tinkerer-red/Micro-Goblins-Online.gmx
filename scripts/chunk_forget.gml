///chunk_forget(chunk_x, chunk_y)

var active_chunks = global.chunk_handler.active_chunks;
var chunk_str = "("+string(argument0)+","+string(argument1)+")";


if ds_map_exists(active_chunks, chunk_str){
  var value = active_chunks[? chunk_str]
  ds_map_delete(active_chunks, chunk_str)
//  return value;
}else{
//  return -1;
}

//if the cell is an interior cell, check to see if the cell was saved to a zone
if (argument0 > global.chunk_handler.world_chunk_width-1)
|| (argument0 < 0)
|| (argument1 > global.chunk_handler.world_chunk_height-1)
|| (argument1 < 0)
{
  if variable_instance_exists(self, "interior_map")
  && variable_instance_exists(self, "interior_grid_x")
  && variable_instance_exists(self, "interior_grid_y"){
    if ds_exists(interior_map, ds_type_map){
      var grid = interior_map[? "chunk_id_grid"];
      if ds_exists(grid, ds_type_grid){
        grid[# interior_grid_x, interior_grid_y] = noone
      }
    }
  }
}
/*
show_debug_message("forget")
var _j = json_encode(active_chunks)
show_debug_message(_j)

