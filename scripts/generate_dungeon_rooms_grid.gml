///generate_dungeon_rooms_grid(xx, yy, size, interior_map)

var chunk_x = argument0
var chunk_y = argument1
var size = argument2
var map = argument3
var width = size*4 -1
var height = size*4 -1

var blazeIt = 420 //this variable is only used arbitrarily as a incrementor to prevent rooms close to each other from having the exact same room types

var returned = false
while(returned = false){
  ///place the central room
  var left_border = floor((size-1)/2)
  var right_border = width - floor(size/2)
  var yy = 1+size
  var xx =  left_border+floor(scr_noise_2dig(chunk_x*743207, chunk_y*743207) * (right_border - left_border))
  //xx = the left center block of size
  
  //var str = dungeon_room_get_str(chunk_x+xx*blazeIt, chunk_y+yy*blazeIt, "treasure", size)
  
  var x1 = xx
  var y1 = height-yy
  
  var str = dungeon_room_get_str(chunk_x+x1*blazeIt, chunk_y+y1*blazeIt, "center", size);
  
  //once we have the string run it through a function to be able to split the string up into the chunks we tell the function what the top left most corner is,
  // and it will iterate through out the string cutting it down to size for each chunk. 
  returned = chunkify_interior_string(x1, y1, str, map)
  show_debug_message("[CENTRAL ROOM] returned = "+string(returned))
  blazeIt++;
}





///Place the Spawn Room
var x1 = xx
var y1 = height-1

var str = dungeon_room_get_str(chunk_x+x1*blazeIt, chunk_y+y1*blazeIt, "spawn")
returned = chunkify_interior_string(x1, y1, str, map)
show_debug_message("[SPAWN ROOM] returned = "+string(returned))

var zone_pos = map[? "zone_pos"];
var array = interior_chunk_to_xy(zone_pos, x1, y1);

var spawn_x_offset = 8*16;
var spawn_y_offset = 14*16;

map[? "entry_x"] = array[0] + spawn_x_offset;
map[? "entry_y"] = array[1] + spawn_y_offset;

var o_exit = instance_create(array[0]+spawn_x_offset, array[1]+spawn_y_offset+31, obj_dungeon_exit);
o_exit.exit_x = map[? "exit_x"]
o_exit.exit_y = map[? "exit_y"]
o_exit.map = map

/*
///Place the Boss Room
var i = 0;
var finalized = false

while (!finalized){
    var x1 = floor(scr_noise_2dig(chunk_x*8055+i, chunk_x*8055)) * width
    var y1 = floor(scr_noise_2dig(chunk_y*8055, chunk_y*8055+i)) * height
    
    var str = dungeon_room_get_str(chunk_x+x1*blazeIt, chunk_y+y1*blazeIt, "boss", size);
    finalized = chunkify_interior_string(x1, y1, str, map);
    i++
}

if (size > 1){
    ///Place the Puzzle Room
    var i = 0;
    var finalized = false
    
    while (!finalized){
        var x1 = floor(scr_noise_2dig(chunk_x*8055+i, chunk_x*8055)) * width
        var y1 = floor(scr_noise_2dig(chunk_y*8055, chunk_y*8055+i)) * height
        
        var str = dungeon_room_get_str(chunk_x+x1*blazeIt, chunk_y+y1*blazeIt, "boss", size);
        finalized = chunkify_interior_string(x1, y1, str, map);
        i++
    }
    
    
    
    if (size > 2){
        ///Place the __________ Room
        var i = 0;
        var finalized = false
        
        while (!finalized){
            var x1 = floor(scr_noise_2dig(chunk_x*8055+i, chunk_x*8055)) * width
            var y1 = floor(scr_noise_2dig(chunk_y*8055, chunk_y*8055+i)) * height
            
            var str = dungeon_room_get_str(chunk_x+x1*blazeIt, chunk_y+y1*blazeIt, "boss", size);
            finalized = chunkify_interior_string(x1, y1, str, map);
            i++
        }
        
        
        
        if (size > 3){
            ///Place the __________ Room
            var i = 0;
            var finalized = false
            
            while (!finalized){
                var x1 = floor(scr_noise_2dig(chunk_x*8055+i, chunk_x*8055)) * width
                var y1 = floor(scr_noise_2dig(chunk_y*8055, chunk_y*8055+i)) * height
                
                var str = dungeon_room_get_str(chunk_x+x1*blazeIt, chunk_y+y1*blazeIt, "boss", size);
                finalized = chunkify_interior_string(x1, y1, str, map);
                i++
            }
        }
    }
}





