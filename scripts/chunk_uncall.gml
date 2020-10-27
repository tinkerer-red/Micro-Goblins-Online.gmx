///chunk_uncall(cell_x, cell_y)

var cell_x = argument0;
var cell_y = argument1;

var chunk_str = chunk_string(cell_x, cell_y)

var chunk = -1
if ds_map_exists(global.chunk_handler.active_chunks, chunk_str){
  var chunk = global.chunk_handler.active_chunks[? chunk_str]
}


if (chunk != -1){
  with (chunk){
      //clean up any chunk that is out of range
      if (should_exist = false){
        chunk_uncall_forced()
      }
      
      if (generated = false) || (heightmap_grid = -1){
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
}
return false;



