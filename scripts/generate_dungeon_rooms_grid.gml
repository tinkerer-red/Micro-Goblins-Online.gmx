///generate_dungeon_rooms_grid(xx, yy, size, interior_map)

var chunk_x = argument0
var chunk_y = argument1
var size = argument2
var map = argument3
var width = size*4 -1
var height = size*4 -1

var blazeIt = 420 //this variable is only used arbitrarily as a incrementor to prevent rooms close to each other from having the exact same room types

///place the central room
var left_border = floor((size-1)/2)
var right_border = width - floor(size/2)
var yy = 1+size
var xx =  left_border+floor(scr_noise_2dig(chunk_x*743207, chunk_y*743207) * (right_border - left_border))
//xx = the left center block of size

var str = dungeon_room_get_str(chunk_x+xx*blazeIt, chunk_y+yy*blazeIt, "treasure", size)

var x1 = xx-left_border
var y1 = height-yy

var str = dungeon_room_get_str(chunk_x+x1*blazeIt, chunk_y+y1*blazeIt, "treasure", size)

//once we have the string run it through a function to be able to split the string up into the chunks we tell the function what the top left most corner is,
// and it will iterate through out the string cutting it down to size for each chunk. 
chunkify_interior_string(x1, y1, str, map)





///Place the Spawn Room
var x1 = xx
var y1 = height-1

var str = dungeon_room_get_str(chunk_x+x1*blazeIt, chunk_y+y1*blazeIt, "spawn")
chunkify_interior_string(x1, y1, str, map)


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





