///chunk_uncall(cell_x, cell_y)

var cell_x = argument0;
var cell_y = argument1;


with (obj_chunk){
    //clean up any chunk that is out of range
    if (chunk_x = cell_x) && (chunk_y = cell_y) {
      alarm_set(3,1);
      continue;
    }
    
    //clean up any other chunks while we're looping through them all
    var player = instance_nearest(x+sprite_width/2, y+sprite_height/2, obj_player)
    var dist = point_distance(x+sprite_width/2, y+sprite_height/2, player.x, player.y)
    if (dist > (sprite_width + sprite_width*0.707)*(chunk_dist+1))
    {
      should_exist = false
      event_user(1)
      //alarm_set(3,1);
      continue;
    }
    
    //clean up any chunks which had an issue genning, or any which are already outside of the area before the generated.
    if (generated = false) || (heightmap_grid = -1){
      var player = instance_nearest(x+sprite_width/2, y+sprite_height/2, obj_player)
      if !point_in_rectangle(player.x, player.y, bbox_left-(sprite_width*(chunk_dist)), bbox_top-(sprite_height*(chunk_dist)), bbox_right+(sprite_width*(chunk_dist)), bbox_bottom+(sprite_height*(chunk_dist))){
        should_exist = false;
        event_user(1)
        //alarm_set(3,1);
        continue;
      }
    }
    
    
}

return false;



