///interior_rooms_connected_to_bbox(map, grid_x, grid_y)

/*  Returns:
array[0] = bbox_view_up
array[1] = bbox_view_down
array[2] = bbox_view_left
array[3] = bbox_view_right
*/



var map = argument0
var grid_x = argument1
var grid_y = argument2

var room_connections_grid = map[? "room_connections_grid"]
var zone_pos = map[? "zone_pos"]
//var tile_size = global.chunk_handler.tile_size
var chunk_width = global.chunk_handler.chunk_width
var chunk_height = global.chunk_handler.chunk_height



//if the connected rooms is still 0 then it is a 1x1 room and we can assume the bbox
if (room_connections_grid[# grid_x, grid_y] = 0){
  var array = interior_chunk_to_xy(zone_pos, grid_x, grid_y);
  
  var bbox_view_left = array[0]
  var bbox_view_up = array[1]
  var bbox_view_right = bbox_view_left + chunk_width
  var bbox_view_down = bbox_view_up + chunk_height

}else{
  
  
  //loop trhough the distance of interior chunks
  var up_i = 0
  var down_i = 0
  var left_i = 0
  var right_i = 0
  
  var up = 1
  var right = 2
  var down = 4
  var left = 8
  
  //up
  repeat(global.chunk_handler.interior_zone_size){
    if (room_connections_grid[# grid_x, grid_y-up_i] & up = up){
      up_i++
    }
    if (grid_y-up_i < 0) break;
  }
  //down
  repeat(global.chunk_handler.interior_zone_size){
    if (room_connections_grid[# grid_x, grid_y+down_i] & down = down){
      down_i++
    }
    if (grid_y-down_i >= global.chunk_handler.interior_zone_size-1) break;
  }
  //left
  repeat(global.chunk_handler.interior_zone_size){
    if (room_connections_grid[# grid_x-left_i, grid_y] & left = left){
      left_i++
    }
    if (grid_x-left_i < 0) break;
  }
  //right
  repeat(global.chunk_handler.interior_zone_size){
    if (room_connections_grid[# grid_x+right_i, grid_y] & right = right){
      right_i++
    }
    if (grid_x-right_i >= global.chunk_handler.interior_zone_size-1) break;
  }
  
  
  //now find the actual bounding boxes
  var array = interior_chunk_to_xy(zone_pos, grid_x, grid_y);
  
  var bbox_view_left = array[0] - (chunk_width*left_i)
  var bbox_view_up = array[1] - (chunk_height*up_i)
  var bbox_view_right = array[0] + chunk_width + (chunk_width*right_i)
  var bbox_view_down = array[1] + chunk_height + (chunk_height*down_i)
  
  show_debug_player(0, "up_i = "+string(up_i))
  show_debug_player(0, "down_i = "+string(down_i))
  show_debug_player(0, "left_i = "+string(left_i))
  show_debug_player(0, "right_i = "+string(right_i))
  
  
}


var array;

array[0] = bbox_view_up
array[1] = bbox_view_down
array[2] = bbox_view_left
array[3] = bbox_view_right

return array;



