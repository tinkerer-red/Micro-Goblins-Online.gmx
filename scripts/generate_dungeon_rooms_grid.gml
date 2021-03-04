///generate_dungeon_rooms_grid(xx, yy, size, interior_map)

var chunk_x = argument0 //exterior cell location for random number generation
var chunk_y = argument1 //exterior cell location for random number generation
var size = argument2  // 1-4
var map = argument3  //map id
var width = size*4 -1  //rooms cells wide
var height = size*4 -1 //room cells tall

var blazeIt = 420 //this variable is only used arbitrarily as a incrementor to prevent rooms close to each other from having the exact same room types



// create the ds list to quickly account for which rooms are valid
var valid_rooms_list = ds_list_create()
var room_count = width*height

for (var i = 0; i < room_count; i++){
  ds_list_add(valid_rooms_list, i)
}





var returned = false
while(returned = false){
  ///place the central room
  var right_border = width - size
  var yy = size+size
  var xx =  floor(scr_noise_2dig(chunk_x*743207, chunk_y*743207) * right_border)
  
  var x1 = xx
  var y1 = height-yy
  
  var str = dungeon_room_get_str(chunk_x+x1*blazeIt, chunk_y+y1*blazeIt, "center", size);
  
  //once we have the string run it through a function to be able to split the string up into the chunks we tell the function what the top left most corner is,
  // and it will iterate through out the string cutting it down to size for each chunk. 
  returned = chunkify_interior_string(x1, y1, str, map)
  show_debug_message("[CENTRAL ROOM] returned = "+string(returned))
}
//remove all the illegal rooms from the list
for (var i = 0; i <size; i++){
  for (var j = 0; j < size; j++){
    var value = (x1+i) + ((y1+j)*width)
    var pos = ds_list_find_index(valid_rooms_list, value)
    ds_list_delete(valid_rooms_list, pos)
  }
}


blazeIt++;




///Place the Spawn Room
var x1 = round(xx + (scr_noise_2dig(chunk_x*59435, chunk_y*59435) * (size-1)))
var y1 = height


var str = dungeon_room_get_str(chunk_x+x1*blazeIt, chunk_y+y1*blazeIt, "spawn")
returned = chunkify_interior_string(x1, y1, str, map)
show_debug_message("[SPAWN ROOM] returned = "+string(returned))

//remove all side rooms from valid room list
  //actual spawn room
  var value = (x1) + (y1*width)
  var pos = ds_list_find_index(valid_rooms_list, value)
  ds_list_delete(valid_rooms_list, pos)
  
  //left of the spawn room
  if (x1-1 >= 0){
    var value = (x1-1) + ((y1)*width)
    var pos = ds_list_find_index(valid_rooms_list, value)
    ds_list_delete(valid_rooms_list, pos)
  }
  
  //right of the spawn room
  if (x1+1 >= 0){
    var value = (x1-1) + ((y1)*width)
    var pos = ds_list_find_index(valid_rooms_list, value)
    ds_list_delete(valid_rooms_list, pos)
  }

//place the data and object for the dungeon exit object
var zone_pos = map[? "zone_pos"];
var array = interior_chunk_to_xy(zone_pos, x1, y1);

var spawn_x_offset = 8*16;
var spawn_y_offset = 14*16;

map[? "entry_x"] = array[0] + spawn_x_offset;
map[? "entry_y"] = array[1] + spawn_y_offset;

//create the exit dungeon object
var o_exit = instance_create(array[0]+spawn_x_offset, array[1]+spawn_y_offset+31, obj_dungeon_exit);
o_exit.exit_x = map[? "exit_x"]
o_exit.exit_y = map[? "exit_y"]
o_exit.map = map



blazeIt++;




///Place the Boss Room
var i = 0;
var finalized = false

while (!finalized){
  var pos = floor(scr_noise_2dig(chunk_x*8055+i, chunk_x*8055) * ds_list_size(valid_rooms_list))
  var val = valid_rooms_list[| pos]
  ds_list_delete(valid_rooms_list, pos)
  
  var x1 = val mod width;
  var y1 = val div width;
      
  var str = dungeon_room_get_str(chunk_x+x1*blazeIt, chunk_y+y1*blazeIt, "boss", size);
  finalized = chunkify_interior_string(x1, y1, str, map);
  i++
  show_debug_message("[BOSS ROOM] returned = "+string(finalized))
}


blazeIt++;






if (size > 1){
    ///Place the Treasure Room
    var i = 0;
    var finalized = false
    
    while (!finalized){
      var pos = floor(scr_noise_2dig(chunk_x*743534+i, chunk_x*743534) * ds_list_size(valid_rooms_list))
      var val = valid_rooms_list[| pos]
      ds_list_delete(valid_rooms_list, pos)
      
      var x1 = val mod width;
      var y1 = val div width;
          
      var str = dungeon_room_get_str(chunk_x+x1*blazeIt, chunk_y+y1*blazeIt, "treasure", size);
      show_debug_message(str)
      finalized = chunkify_interior_string(x1, y1, str, map);
      i++
      show_debug_message("[TREASURE ROOM] returned = "+string(finalized))
    }
    
    
    blazeIt++;
    
    
    
    
    
    ///Place the Puzzle Room
    var i = 0;
    var finalized = false
    
    while (!finalized){
        var pos = floor(scr_noise_2dig(chunk_x*8055, chunk_x*8055) * ds_list_size(valid_rooms_list))
        var val = valid_rooms_list[| pos]
        ds_list_delete(valid_rooms_list, pos)
        
        var x1 = val mod width;
        var y1 = val div width;
            
        var str = dungeon_room_get_str(chunk_x+x1*blazeIt, chunk_y+y1*blazeIt, "puzzle", size);
        finalized = chunkify_interior_string(x1, y1, str, map);
        i++
        show_debug_message("[PUZZLE ROOM] returned = "+string(finalized))
    }
    
    
    /*
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
    */
}





