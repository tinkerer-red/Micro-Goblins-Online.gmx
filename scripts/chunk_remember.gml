///chunk_remember(chunk_x, chunk_y, chunk_id)

var xx = argument0*global.chunk_handler.chunk_width
var yy = argument1*global.chunk_handler.chunk_height
var chunk_id = argument2

if is_interior(xx, yy){
    //find the zone, if it exists
    
    //find the slot
    var array = interior_chunk_find_grid_pos(argument0, argument1)
    if (array = undefined){
      chunk_uncall_forced()
      return false;
    }
    var grid_x = array[0]
    var grid_y = array[1]
    var map = array[2]
    
    //find out if there is a chunk there
    var chunk_id_grid = map[? "chunk_id_grid"]
    if (chunk_id_grid[# grid_x, grid_y] = noone){
        //add it to the slot
        chunk_id_grid[# grid_x, grid_y] = chunk_id
        
        chunk_id.image_blend = c_lime
        chunk_id.interior_grid_x = grid_x
        chunk_id.interior_grid_y = grid_y
        chunk_id.interior_map = map
    }else{
        chunk_uncall_forced()
    }
    
    
}else{
    ds_map_add(active_chunks, "("+string(argument0)+","+string(argument1)+")", argument2)
}
