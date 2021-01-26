///chunk_uncall(cell_x, cell_y)

var cell_x = argument0;
var cell_y = argument1;
var xx = cell_x*global.chunk_handler.chunk_width
var yy = cell_y*global.chunk_handler.chunk_height

var chunk_str = chunk_string(cell_x, cell_y)




var chunk = noone
//check for exterior chunks
if ds_map_exists(global.chunk_handler.active_chunks, chunk_str){
  var chunk = global.chunk_handler.active_chunks[? chunk_str]
}

//check to see if the cell is an interior chunk
if (chunk = noone){
  if is_interior(xx, yy){
    var array = interior_chunk_find_grid_pos(cell_x, cell_y)
    
    if (array != undefined){
      var grid_x = array[0]
      var grid_y = array[1]
      var map = array[2]
      //show_debug_message("grid_x = "+string(grid_x))
      //show_debug_message("grid_y = "+string(grid_y))
      //show_debug_message("map = "+string(map))
      
      var chunk_id_grid = map[? "chunk_id_grid"]
      var chunk = chunk_id_grid[# abs(grid_x), abs(grid_y)]
      
    }
  }
}

//if the desired chunk appears in no maps, how will we find it's id? with a collision check?
if (chunk = noone){
  var chunk = collision_point( xx, yy, obj_chunk, false, false);
}




if (chunk >= 0){ //if the chunk isnt in the negative values
  with (chunk){
      //clean up any chunk that is out of range
      if (should_exist = false){
        chunk_uncall_forced()
        return false;
      }
      
      if (generated = false)
      || (heightmap_grid = -1){
        var player = instance_nearest(x+sprite_width/2, y+sprite_height/2, obj_player)
        if !point_in_rectangle(player.x, player.y, bbox_left-(sprite_width*(chunk_dist)), bbox_top-(sprite_height*(chunk_dist)), bbox_right+(sprite_width*(chunk_dist)), bbox_bottom+(sprite_height*(chunk_dist))){
          should_exist = false;
          event_user(1)
          //alarm_set(3,1);
          continue;
        }
      }
      
      alarm_set(3,1);
      continue;
      
  }
}else{
}


return false;



