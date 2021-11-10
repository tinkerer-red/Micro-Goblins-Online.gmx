///generate_dungeon_rooms_grid(xx, yy, size, interior_map)

var chunk_x = argument0 //exterior cell location for random number generation
var chunk_y = argument1 //exterior cell location for random number generation
var size = argument2  // 1-4
var map = argument3  //map id
var width = size*4 -1  //rooms cells wide
var height = size*4 -1 //room cells tall


// this variable is only used arbitrarily as a incrementor to prevent rooms
// close to each other from having the exact same room types
// only named it this way because it give me something to laugh at
var blazeIt = 420 




// create the ds list to quickly account for which rooms are valid
var valid_rooms_list = ds_list_create()
var room_count = (width+1)*(height+1)

for (var i = 0; i < room_count; i++){
  ds_list_add(valid_rooms_list, i)
}


//init the hallway exist grid, so when we spawn the spawn room and the
// entrance hallway we can tell that grid that the connecting rooms should
// never have anything connected to them
var hallway_preference_grid = ds_grid_create(width+1, height+1)
var infinity = (width+1)*(height+1) + 1
var room_coord_queue = ds_queue_create() //this queue is used to store all the room coords as array's so we can pull them back out in order at the end of generation for the hallways














///place the central room
var returned = false
while(returned = false){
  
  var yy = size+size
  var xx =  round(scr_noise_2dig(chunk_x*743207, chunk_y*743207) * ((width) - (size-1)))
  
  var x1 = xx
  var y1 = height-yy
  
  var str = dungeon_room_get_str(chunk_x+x1*blazeIt, chunk_y+y1*blazeIt, "center", size);
  
  
  
  //once we have the string run it through a function to be able to split the string up into the chunks we tell the function what the top left most corner is,
  // and it will iterate through out the string cutting it down to size for each chunk. 
  returned = chunkify_interior_string(x1, y1, str, map, valid_rooms_list, size)
  ////show_debug_message("[CENTRAL ROOM] returned = "+string(returned))
}
//grad some data for the hallway gen later
  var center_xx  = x1
  var center_yy  = y1
  var center_width  = hex_to_dec( string_copy(str, 1, 2))
  var center_height = hex_to_dec( string_copy(str, 3, 2))
  var ideal_cx = x1+(center_width/2)
  var ideal_cy = y1+(center_height/2)

//remove all the illegal rooms from the list
for (var i = 0; i <size; i++){
  for (var j = 0; j < size; j++){
    var value = (x1+i) + ((y1+j)*(width+1))
    var pos = ds_list_find_index(valid_rooms_list, value)
    ds_list_delete(valid_rooms_list, pos)
  }
}


blazeIt++;





  



///Place the Spawn Room
var x1 = xx + round(scr_noise_2dig(chunk_x*59435, chunk_y*59435) * (size-1))
var y1 = height

var illegal_hall_zone_x2 = x1
var illegal_hall_zone_y2 = y1


var str = dungeon_room_get_str(chunk_x+x1*blazeIt, chunk_y+y1*blazeIt, "spawn")
returned = chunkify_interior_string(x1, y1, str, map, valid_rooms_list, size);
//show_debug_message("[SPAWN ROOM] returned = "+string(returned))


//remove all side rooms from valid room list
  //actual spawn room
  hallway_preference_grid[# x1 , y1] = infinity  //remember not to spawn any hallways touching this room
  var value = (x1) + (y1*(width+1))
  var pos = ds_list_find_index(valid_rooms_list, value)
  ds_list_delete(valid_rooms_list, pos)
  
  //left of the spawn room
  if (x1-1 >= 0){
    hallway_preference_grid[# x1-1 , y1] = infinity  //remember not to spawn any hallways touching this room
    var value = (x1-1) + ((y1)*(width+1))
    var pos = ds_list_find_index(valid_rooms_list, value)
    ds_list_delete(valid_rooms_list, pos)
  }
  
  //right of the spawn room
  if (x1+1 <= width){
    hallway_preference_grid[# x1+1 , y1] = infinity  //remember not to spawn any hallways touching this room
    var value = (x1+1) + ((y1)*(width+1))
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
o_exit.exit_x = map[? "exit_x"];
o_exit.exit_y = map[? "exit_y"];
o_exit.map = map;



blazeIt++;









//Place the Entrence Hallway Rooms
for(var y1 = height-1; y1 >= height-size; y1--){

  //var x1 = x1;
  //var y1 = y1 - 1;
  var returned = false
  while(returned = false){
    
    var start_of_string = "";
    
    //while the room is not a 1x1 cell
    while (start_of_string != "0101"){
      //cycle through possible strings untill one is
      var str = dungeon_room_get_str(chunk_x+x1+blazeIt, chunk_y+y1*blazeIt, "hall");
      start_of_string = string_copy(str, 1, 4)
      blazeIt++;
    }
    
    returned = chunkify_interior_string(x1, y1, str, map, valid_rooms_list, size)
    //show_debug_message("[Entrance HALL ROOM] returned = "+string(returned))
    
    //remove all side rooms from valid room list
    //actual hallway room
    hallway_preference_grid[# x1 , y1] = infinity  //remember not to spawn any hallways touching this room
    var value = (x1) + (y1*(width+1))
    var pos = ds_list_find_index(valid_rooms_list, value)
    ds_list_delete(valid_rooms_list, pos)
    
    //mark illegal zones on first pass
    var illegal_hall_zone_x1 = x1
    var illegal_hall_zone_y1 = y1
    
    //left of the hallway room
    if (x1-1 >= 0){
      hallway_preference_grid[# x1-1 , y1] = infinity  //remember not to spawn any hallways touching this room
      var value = (x1-1) + ((y1)*(width+1))
      var pos = ds_list_find_index(valid_rooms_list, value)
      ds_list_delete(valid_rooms_list, pos)
      
      //mark illegal zones on second pass
      //we also mark illegal zones here incase they aren't on the edge of the grid
      var illegal_hall_zone_x1 = x1-1
      var illegal_hall_zone_y1 = y1
    }
    
    //right of the hallway room
    if (x1+1 <= width){
      hallway_preference_grid[# x1+1 , y1] = infinity  //remember not to spawn any hallways touching this room
      var value = (x1+1) + ((y1)*(width+1))
      var pos = ds_list_find_index(valid_rooms_list, value)
      ds_list_delete(valid_rooms_list, pos)
    }
    
    blazeIt++;
  }
}






///Place the Boss Room
var finalized = false

while (!finalized){
  var pos = floor(scr_noise_2dig(chunk_x*8055+blazeIt, chunk_x*8055) * ds_list_size(valid_rooms_list))
  var val = valid_rooms_list[| pos]
  
  var x1 = val mod width;
  var y1 = val div width;
   
  var str = dungeon_room_get_str(chunk_x+x1*blazeIt, chunk_y+y1*blazeIt, "boss", size);
  finalized = chunkify_interior_string(x1, y1, str, map, valid_rooms_list, size);
  //show_debug_message("[BOSS ROOM] returned = "+string(finalized))
  blazeIt++;
}
//store the value for future use when spawning hallways
//grad some data for the hallway gen later
  var boss_width  = hex_to_dec( string_copy(str, 1, 2))
  var boss_height = hex_to_dec( string_copy(str, 3, 2))
  var boss_coord_array;
  boss_coord_array[0] = x1+(boss_width/2)
  boss_coord_array[1] = y1+(boss_height/2)
  ds_queue_enqueue(room_coord_queue, boss_coord_array)

//now remove the rooms from the possible room list
generate_dungeon_rooms_grid_remove_surrounding_rooms(str, x1, y1, size, valid_rooms_list)









if (size > 1){
    ///Place the Treasure Room
    var finalized = false
    
    while (!finalized){
      var pos = floor(scr_noise_2dig(chunk_x*743534+blazeIt, chunk_x*743534) * ds_list_size(valid_rooms_list))
      var val = valid_rooms_list[| pos]
      //ds_list_delete(valid_rooms_list, pos)
      
      var x1 = val mod width;
      var y1 = val div width;
        
      var str = dungeon_room_get_str(chunk_x+x1*blazeIt, chunk_y+y1*blazeIt, "treasure", size);
      ////show_debug_message(str)
      finalized = chunkify_interior_string(x1, y1, str, map, valid_rooms_list, size);
      //show_debug_message("[TREASURE ROOM] returned = "+string(finalized))
      blazeIt++;
    }
    //store the value for future use when spawning hallways
    //grad some data for the hallway gen later
      var treasure_width  = hex_to_dec( string_copy(str, 1, 2))
      var treasure_height = hex_to_dec( string_copy(str, 3, 2))
      var treasure_coord_array;
      treasure_coord_array[0] = x1+(treasure_width/2)
      treasure_coord_array[1] = y1+(treasure_height/2)
      ds_queue_enqueue(room_coord_queue, treasure_coord_array)
    
    //now remove the rooms from the possible room list
    generate_dungeon_rooms_grid_remove_surrounding_rooms(str, x1, y1, size, valid_rooms_list)
    
    
    
    
    
    ///Place the Puzzle Room
   var finalized = false
    
    while (!finalized){
        var pos = floor(scr_noise_2dig(chunk_x*8055, chunk_x*8055+blazeIt) * ds_list_size(valid_rooms_list))
        var val = valid_rooms_list[| pos]
        //ds_list_delete(valid_rooms_list, pos)
        
        var x1 = val mod width;
        var y1 = val div width;
        
        var str = dungeon_room_get_str(chunk_x+x1*blazeIt, chunk_y+y1*blazeIt, "puzzle", size);
        finalized = chunkify_interior_string(x1, y1, str, map, valid_rooms_list, size);
        //show_debug_message("[PUZZLE ROOM] returned = "+string(finalized))
        blazeIt++;
    }
    //store the value for future use when spawning hallways
    //grad some data for the hallway gen later
      var puzzle_width  = hex_to_dec( string_copy(str, 1, 2))
      var puzzle_height = hex_to_dec( string_copy(str, 3, 2))
      var puzzle_coord_array;
      puzzle_coord_array[0] = x1+(puzzle_width/2)
      puzzle_coord_array[1] = y1+(puzzle_height/2)
      ds_queue_enqueue(room_coord_queue, puzzle_coord_array)
        
    //now remove the rooms from the possible room list
    generate_dungeon_rooms_grid_remove_surrounding_rooms(str, x1, y1, size, valid_rooms_list)
    
    
    /*
    if (size > 2){
        ///Place the __________ Room
        var i = 0;
        var finalized = false
        
        while (!finalized){
            var x1 = floor(scr_noise_2dig(chunk_x*8055+i, chunk_x*8055)) * width
            var y1 = floor(scr_noise_2dig(chunk_y*8055, chunk_y*8055+i)) * height
            
            var str = dungeon_room_get_str(chunk_x+x1*blazeIt, chunk_y+y1*blazeIt, "boss", size);
            finalized = chunkify_interior_string(x1, y1, str, map, valid_rooms_list, size);
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
                finalized = chunkify_interior_string(x1, y1, str, map, valid_rooms_list, size);
                i++
            }
        }
    }
    */
}




















//after all the rooms are now in place lets create the optimal hallway pathing

//init values
var hallway_exists_grid = ds_grid_create(width+1, height+1)
var room_grid = map[? "room_grid"]

//cycle through grid, filling out possible possitions, or illegal ones
for (var xx = 0; xx <= width; xx++){
  for (var yy = 0; yy <= height; yy++){
    
    hallway_exists_grid[# xx , yy] = false
    
    //if room data exists in this chunk set the value to infinity so we never try to place a hallway there
    if (room_grid[# xx, yy] != "")
    || (hallway_preference_grid[# xx , yy] != 0){
      hallway_preference_grid[# xx , yy] = infinity
      continue;}
    
    //optimal hallway direction values
    hallway_preference_grid[# xx, yy] = elliptical_gradient_non_centered(xx, yy, ideal_cx, ideal_cy, width, height, 0)
    
    //now lets add in some variation to the dungeon halls by adding in some relatively
    // smooth value noise additive to add some slight deviations from an optimal path
    hallway_preference_grid[# xx, yy] += (scr_vn_noise(0, 1, 1, 1, 0.1, xx+chunk_x, j+chunk_y)*0.25)
  }
}

ds_grid_print(hallway_preference_grid)
//once our ideal hallway grid is in place, we will cycle through the list of all
// the room's center points and move as close to the central room as we can before
// we run into a blank room data. Blank room data would imply that nothing has
// generated in that cell which means this room is not properly connected to the
// central room, or another less important room.

repeat(ds_queue_size(room_coord_queue)){
  var dx = 0
  var dy = 0
  
  var array = ds_queue_dequeue(room_coord_queue)
  
  var xx = array[0]
  var yy = array[1]
  
  var is_connected = false;
  
  //cycle through connected rooms, untill the two direction rooms have no data, or untill we have reached the center of the central room
  while (room_grid[#xx+dx, yy] != "") && (room_grid[#xx, yy+dy] != ""){
    xx += dx;
    yy += dy;
    
    //if we have reached the central room break, because there would be no reason to create a hallway if we are allready connected
    if (floor(xx) = floor(ideal_cx)) && (floor(yy) = floor(ideal_cy)){
      is_connected = true;
      break;
    }
    
    //reset values
    var dx = 0;
    var dy = 0;
    
    //find the direction
    var dir = point_direction(floor(xx), floor(yy), floor(ideal_cx), floor(ideal_cy))
    //find the new direction
    dx = sign(round(lengthdir_x(1,dir)-.2))
    dy = sign(round(lengthdir_y(1,dir)-.2))
  }
  
  //now actually create halls
  if (is_connected = false){
    var hall_x = floor(xx)
    var hall_y = floor(yy)
    
    var last_x = hall_x
    var last_y = hall_y
    
    while ((hall_x < center_xx)
    || (hall_x > center_xx+center_width-1))
    || ((hall_y < center_yy)
    || (hall_y > center_yy+center_height-1)){
      
    //find the 4 locations
      var up, down, left, right;
      
      //right
      if (hall_x+1 >= ds_grid_width(hallway_preference_grid))
      || ((hall_x+1 = last_x) && (hall_y = last_y))
      {right = infinity}
      else{
        if (hallway_exists_grid[# hall_x+1, hall_y] = true) {break;}
        right = hallway_preference_grid[# hall_x+1, hall_y]
      }
      
      //left  
      if (hall_x-1 < 0)
      || ((hall_x-1 = last_x) && (hall_y = last_y))
      {left = infinity}
      else{
        if (hallway_exists_grid[# hall_x-1, hall_y] = true) {break;}
        left = hallway_preference_grid[# hall_x-1, hall_y]
      }
      
      //down
      if (hall_y+1 >= ds_grid_height(hallway_preference_grid))
      || ((hall_x = last_x) && (hall_y+1 = last_y))
      {down = infinity}
      else{
        if (hallway_exists_grid[# hall_x, hall_y+1] = true) {break;}
        down = hallway_preference_grid[# hall_x, hall_y+1]
      }
      
      //up
      if (hall_y-1 < 0)
      || ((hall_x = last_x) && (hall_y-1 = last_y))
      {up = infinity}
      else{
        if (hallway_exists_grid[# hall_x, hall_y-1] = true) {break;}
        up = hallway_preference_grid[# hall_x, hall_y-1]
      }
      
      var last_x = hall_x
      var last_y = hall_y
      
      //if for some reason they are not defined give them a value of infinity +1
      //  this is because the hallways is on the edge of the ds_grid, and we cant expand it
      if (up = undefined) {up = infinity+1}
      if (down = undefined) {down = infinity+1}
      if (left = undefined) {left = infinity+1}
      if (right = undefined) {right = infinity+1}
      
      //sometimes with the noise function which adds some speratic hallways,
      //  the halway has a chance to loop in a circle into it's self, leading to no way out
      //  this break prevents that from happening just by giving up.
      //  this theoretically means it's possible to have a dungeon which can not be defeated 
      // IE Impossible dungeon genoration.
      if (up >= infinity)
      && (down >= infinity)
      && (left >= infinity)
      && (right >= infinity){
        break;
      }
      //increment to the best possible possition
      
      var min_val = min(up, down, left, right)
      switch min_val
      {
        case up:
          hall_y--
        break;
        case down:
          hall_y++
        break;
        case left:
          hall_x--
        break;
        case right:
          hall_x++
        break;
      }
      
      //once we have our best possition, check to see if there is anything there
      if (room_grid[# hall_x, hall_y] = ""){
        
        //if we are free to place hallways there, then now we can finally gen a room
        //while the room is not infringing on "illegal_hall_zone" for spawn
        finalized = false;
        while (finalized = false){
          //cycle through possible strings untill one is
          var str = dungeon_room_get_str(chunk_x+x1+4411+blazeIt, chunk_y+y1*blazeIt, "hall");
          var hall_w  = hex_to_dec( string_copy(str, 1, 2))-1
          var hall_h = hex_to_dec( string_copy(str, 3, 2))-1
          
          if rectangle_in_rectangle(hall_x, hall_y, hall_x+hall_w-1, hall_y+hall_h-1, illegal_hall_zone_x1, illegal_hall_zone_y1, illegal_hall_zone_x2, illegal_hall_zone_y2){
            blazeIt++;
            continue;
          }
          
          finalized = chunkify_interior_string(hall_x, hall_y, str, map, valid_rooms_list, size, true);
          
          blazeIt++;
        }
        hallway_exists_grid[# hall_x, hall_y] = true;
        
      }
    }
    
  }
}

//if we now know that the room is in no way connected to the central room, we can
// allow the room to gen a hallway to the central room, or if it happens to run
// accross another hallway only 1 chunk away from it, just merge together with the
// other hallway





//cleanup
ds_list_destroy(valid_rooms_list)
ds_grid_destroy(hallway_preference_grid)
ds_queue_destroy(room_coord_queue)
ds_grid_destroy(hallway_exists_grid)
