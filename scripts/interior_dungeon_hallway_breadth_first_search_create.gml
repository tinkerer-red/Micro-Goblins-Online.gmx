///interior_dungeon_hallway_breadth_first_search_create(hcells, vcells, cx, cy)

/*
   Returns Array
  width = how many cells wide
  height = how many cells high
  cx = the optimal location in the dungeon
  cy = the optimal location in the dungeon
*/
/*
var width = argument2,
    height = argument3,
    tile_width = argument4,
    tile_height = argument5,
    xx = argument0 - (argument0 mod tile_width),
    yy = argument1 - (argument1 mod tile_height),
    cx = (argument6 - xx) div tile_width,
    cy = (argument7 - yy) div tile_height;

//var array = 0;
var visited = 0;
var infinity = width*height+1 //9223372036854775299 is the largest number the compiler will accept, although for larger project you may wish to use smaller numbers to save memory

/// fill the array with zeors
for (var i = width-1; i >= 0; i--){
  for (var j = height-1; j >= 0; j--){
    array[i,j] = infinity
    visited[i,j] = false
  }
}

/// initialize corisponing cell values
var x1 = infinity
    x2 = infinity
    y1 = infinity
    y2 = infinity

/// create the queues
//var queue = ds_queue_create()

/// define starting location
ds_queue_enqueue(queue, cx)
ds_queue_enqueue(queue, cy)
visited[cx,cy] = true

/// cycle through the cells populating them
while !ds_queue_empty(queue) {
  
  // grab the cell we're about to focus on
  var _xx = ds_queue_dequeue(queue)
  var _yy = ds_queue_dequeue(queue)
  
  //show_debug_message("While loop restart")
  //show_debug_message("_xx = "+string(_xx)+" _yy = "+string(_yy))
  
  // if you want a desired radius you can change this here
  //*
  var cell_range = 20
  if (point_distance(_xx, _yy, cx, cy) > cell_range){
    array[_xx, _yy] = infinity
    continue;
  }
  //* /
  
  // if it's our starting location set it to one
  if ((_xx = cx) && (_yy = cy)) {
    array[_xx, _yy] = 1
    //also queue up the next values
        if (_xx - 1 >= 0){
          ds_queue_enqueue(queue, _xx-1)
          ds_queue_enqueue(queue, _yy)}
        if (_xx + 1 < width){
          ds_queue_enqueue(queue, _xx+1)
          ds_queue_enqueue(queue, _yy)}
        if (_yy - 1 >= 0){
          ds_queue_enqueue(queue, _xx)
          ds_queue_enqueue(queue, _yy-1)}
        if (_yy + 1 < height){
          ds_queue_enqueue(queue, _xx)
          ds_queue_enqueue(queue, _yy+1)}
    continue;
  }
  
  // if the cell we're checking has not been filled out yet
  //if (array[_xx, _yy] = 0){
    //_x - (_x mod tile_get_width(_tile));
    world_x = (xx - xx mod tile_width) + (_xx * tile_width)
    world_y = (yy - yy mod tile_width) + (_yy * tile_height)
    //*
    //if the tile is ocupied
    if !chunk_tile_free(world_x, world_y, "layer_obsticals"){
      array[_xx, _yy] = infinity;
      continue;
      // we wont add the next cells because we might pass through the wall
    }
    
    //if there is a solid object in our way
    if collision_rectangle( world_x, world_y, world_x+tile_width-1, world_y+tile_height-1, obj_solid, false, true ){
      array[_xx, _yy] = infinity;
      //show_debug_message("solid")
      continue;
      // we wont add the next cells because we might pass through the wall
    }
    //* /
    
    // if we're free of collisions we can add to the values
    
    // grab the four values neughboring us
    if (_xx - 1 >= 0) {
      if (array[_xx - 1, _yy] != infinity){
        var x1 = array[_xx - 1, _yy]
      }else{
        var x1 = infinity
        if !visited[_xx-1,_yy]{
          ds_queue_enqueue(queue, _xx-1)
          ds_queue_enqueue(queue, _yy)
          visited[_xx-1, _yy] = true
        }
      }
    }//else{var x1 = infinity}
    
    if (_xx + 1 < width) {
      if (array[_xx + 1, _yy] != infinity){
        var x2 = array[_xx + 1, _yy]
      }else{
        var x2 = infinity
        if !visited[_xx+1,_yy]{
          ds_queue_enqueue(queue, _xx+1)
          ds_queue_enqueue(queue, _yy)
          visited[_xx+1, _yy] = true
        }
      }
    }//else{var x2 = infinity}
    
    if (_yy - 1 >= 0) {
      if (array[_xx, _yy - 1] != infinity){
        var y1 = array[_xx, _yy - 1]
      }else{
        var y1 = infinity
        if !visited[_xx,_yy-1]{
          ds_queue_enqueue(queue, _xx)
          ds_queue_enqueue(queue, _yy-1)
          visited[_xx, _yy-1] = true
        }
      }
    }//else{var y1 = infinity}
    
    if (_yy + 1 < height) {
      if (array[_xx, _yy + 1] != infinity){
        var y2 = array[_xx, _yy + 1]
      }else{
        var y2 = infinity
        if !visited[_xx,_yy+1]{
          ds_queue_enqueue(queue, _xx)
          ds_queue_enqueue(queue, _yy+1)
          visited[_xx, _yy+1] = true
        }
      }
    }//else{var y2 = infinity}
    
    
    // find the optimal value, and set the cell to it
    array[_xx, _yy] = min(x1, x2, y1, y2)+1
    
//  }
}

//clear the data structures
//ds_queue_destroy(queue)



//return array;







