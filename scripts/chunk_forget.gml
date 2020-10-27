///chunk_forget(chunk_x, chunk_y, chunk_id)

var active_chunks = global.chunk_handler.active_chunks;
var chunk_str = "("+string(argument0)+","+string(argument1)+")";


if ds_map_exists(active_chunks, chunk_str){
  var value = active_chunks[? chunk_str]
  ds_map_delete(active_chunks, chunk_str)
  return value;
}else{
  return -1;
}

