///chunk_interior_player_in_zone([chunk_x,chunk_y])

if (argument_count = 2){
  var xx = argument[0]*global.chunk_handler.chunk_width
  var yy = argument[1]*global.chunk_handler.chunk_height
}else{
  var xx = x
  var yy = y
}

//grab the chunk values
var active_chunks = global.chunk_handler.active_chunks
var tile_size = global.chunk_handler.tile_size
var width = global.chunk_handler.chunk_width
var height = global.chunk_handler.chunk_height

//find the chunks location
var chunk_x = xx div width
var chunk_y = yy div height

var int_chunk_x = chunk_x - global.chunk_handler.world_chunk_width
var int_chunk_y = chunk_y

//now find the zone
var zones_per_col = global.chunk_handler.world_chunk_height div global.chunk_handler.interior_zone_size

var zone_x = int_chunk_x div global.chunk_handler.interior_zone_size
var zone_y = int_chunk_y div global.chunk_handler.interior_zone_size

var zone_pos = zone_x*zones_per_col + zone_y

var array1 = interior_chunk_to_xy(zone_pos, 0, 0)
var array2 = interior_chunk_to_xy(zone_pos, global.chunk_handler.interior_zone_size, global.chunk_handler.interior_zone_size)

var zone_x1 = array1[0]
var zone_y1 = array1[1]
var zone_x2 = array2[0]
var zone_y2 = array2[1]


//now test all local players and if any are true then return true
with (obj_player){
  if player_is_local(){
    if (x > zone_x1)
    && (x < zone_x2)
    && (y > zone_y1)
    && (y < zone_y2){
      return true;
    }
  }
}

return false;
