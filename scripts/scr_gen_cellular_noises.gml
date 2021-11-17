///scr_gen_cellular_noises(oc, pers, wm, lac, isIsland, refined, perc, seed)
/*
  oc = 
  pers = 
  wm = 
  lac = 
  isIsland = 
  refined = 
  perc = 
  
  Octaves - How many layers of noise will be summarised for the final output. More octave, more errosion.
  Persistence - How fast amplitude of each new octave will diminish. Higher values = more random generation.
  Lacunarity - How much wmuency of each new octave will increase. Lower values = smoother islands \ terrain.
  Is island - If 1, elliptical gradient is applied and island will be generated. If 0, full room terrain will be ganerated.
  
  Wavelength modifier is basically a Chunk Size. 
  At 1 the chunk for generation will be = grid width / 1.
  2 = grid width / 2. Etc.
  2 - 4 is optimal for good looking islands. 
  But if you want more eroded islands or more smaller details for full room terrain, you can try higher numbers.
*/


var oc = argument0,
    pers = argument1,
    wm = argument2,
    lac = argument3,
    isIsland = argument4,
    refined = argument5,
    perc = argument6,
    seed = argument7;


var tile_size = global.chunk_handler.tile_size;
var grid_size_x = (sprite_width/tile_size)+2;
var grid_size_y = (sprite_height/tile_size)+2;

var world_width  = global.chunk_handler.world_width  /tile_size
var world_height = global.chunk_handler.world_height /tile_size

var x_off = bbox_left/tile_size-1
var y_off = bbox_top/tile_size-1


///create every grid we're about to use
var grid0 = ds_grid_create(grid_size_x, grid_size_y),  //CellValue
    grid1 = ds_grid_create(grid_size_x, grid_size_y),  //Distance
    grid2 = ds_grid_create(grid_size_x, grid_size_y),  //Distance2
    grid3 = ds_grid_create(grid_size_x, grid_size_y),  //Distance2Add
    grid4 = ds_grid_create(grid_size_x, grid_size_y),  //Distance2Sub
    grid5 = ds_grid_create(grid_size_x, grid_size_y),  //Distance2Mul
    grid6 = ds_grid_create(grid_size_x, grid_size_y);  //Distance2Div




///before we start lets create an array to hold all 7 grids that we are about to create
var array_of_cell_grids = create_array(grid0,
                                       grid1,
                                       grid2,
                                       grid3,
                                       grid4,
                                       grid5,
                                       grid6)


var left   = x_off
var right  = x_off+grid_size_x
var top    = y_off
var bottom = y_off+grid_size_y



//timer_start()
for(var i = left; i < right; i++){
//show_debug_message("i = "+string(i))
  for(var j = top; j < bottom; j++){
  //show_debug_message("j = "+string(j))
    
    
    var returned_array = DomainWarpSingle(seed, 30, 0.01, 1, i, j);
    var _i = returned_array[0];
    var _j = returned_array[1];
    //show_debug_message("_i = "+string(_i))
    //show_debug_message("_j = "+string(_j))
    
    //this is essentially an extremely optimized version of scr_vn_noise script
    /////////////////////////////////////////////
    //method = argument[6]
    var wm = argument2;
    var amp = 1;
    var maxamp = 0;
    var sum = create_array(0,0,0,0,0,0,0)
    
    for (var k=0; k < oc; ++k){
    //show_debug_message("k = "+string(k))
      ///single_cellular(seed, method, x, y)
      var xx = (i+_i) * wm;
      var yy = (j+_j) * wm;
      var xr = round(xx);
      var yr = round(yy);
      var CellularJitterModifier = 0.80 //argument3;
      
      var MaxValue = 999999999999999;
      var PrimeX = 501125321;
      var PrimeY = 1136930381;
      
      
      var distance0 = MaxValue;
      var distance1 = MaxValue;
      var closestHash = 0;
      
      var cellularJitter = 0.43701595 * CellularJitterModifier;
      
      var xPrimed = (xr - 1) * PrimeX;
      var yPrimedBase = (yr - 1) * PrimeY;
      
      
      ///case CellularDistanceFunction.Hybrid:
      //for (var xi = xr - 1; xi <= xr + 1; xi++)
      for (var xxx = -1; xxx <= 1; xxx++)
      {
        var xi = xr + xxx
      //show_debug_message("xi = "+string(xi))
      //show_debug_message("xr = "+string(xr))
        var yPrimed = yPrimedBase;
          
        //for (var yi = yr - 1; yi <= yr + 1; yi++)
        for (var yyy = -1; yyy <= 1; yyy++)
        {
          var yi = yr + yyy
          
          var normalized_hash = gold_noise(seed, xPrimed, yPrimed);
          var hash = normalized_hash*2-1
          
          var vecX = (xi - xx) + hash * cellularJitter;
          var vecY = (yi - yy) + hash * cellularJitter;
          
          
          
          var newDistance = (abs(vecX) + abs(vecY)) + (vecX * vecX + vecY * vecY);
          
          distance1 = max(min(distance1, newDistance), distance0);
          
          if (newDistance < distance0){
            distance0 = newDistance;
            closestHash = normalized_hash;
          }
          
          yPrimed += PrimeY;
        }
        xPrimed += PrimeX;
      }
      
      distance0 = (distance0 + 1)/2
      distance1 = (distance1 + 1)/2
      
      //case CellularReturnType.CellValue:
      sum[0] += (amp *  (closestHash)  ) // *(1/ 21474836480);
      //case CellularReturnType.Distance:
      sum[1] += (amp *  clamp(distance0*0.5, 0, 1)  );
      //case CellularReturnType.Distance2:
      sum[2] += (amp *  clamp(distance1*0.5, 0, 1)  );
      //case CellularReturnType.Distance2Add:
      sum[3] += (amp *  clamp((distance1*0.5 + distance0*0.5)/2, 0, 1)  );
      //case CellularReturnType.Distance2Sub:
      sum[4] += (amp *  clamp(distance1*0.5 - distance0*0.5, 0, 1)  );
      //case CellularReturnType.Distance2Mul:
      sum[5] += (amp *  clamp(distance1*distance0/4, 0, 1)  );
      //case CellularReturnType.Distance2Div:
      sum[6] += (amp *  clamp(distance0/distance1, 0, 1)  );
      
      
      wm *= 2;
      maxamp += amp;
      amp *= pers;
      
    }
    
    /*
    var maxVal, minVal;
    minVal[0] = -1.00;
    maxVal[0] =  1.00;
    
    minVal[1] =  0;
    maxVal[1] =  2;
    
    minVal[2] =  0.0;
    maxVal[2] =  3.1050141370285043;
    
    minVal[3] =  0.0;
    maxVal[3] =  2.0;
    
    minVal[4] =  0.00;
    maxVal[4] =  2.5070009336502297;;
    
    minVal[5] =  0.00;
    maxVal[5] =  2.00;
    
    minVal[6] =  0.00;
    maxVal[6] =  1.40;
    */
    
    grid0[# i-x_off, j-y_off] = (sum[0] / maxamp)
    grid1[# i-x_off, j-y_off] = (sum[1] / maxamp)
    grid2[# i-x_off, j-y_off] = (sum[2] / maxamp)
    grid3[# i-x_off, j-y_off] = (sum[3] / maxamp)
    grid4[# i-x_off, j-y_off] = (sum[4] / maxamp)
    grid5[# i-x_off, j-y_off] = (sum[5] / maxamp)
    grid6[# i-x_off, j-y_off] = (sum[6] / maxamp)
    
    //show_debug_message(""+string_format(sum[6], 1, 16))
    
    //*
    if (grid0[# i-x_off, j-y_off] < 0) show_debug_message("sum[0] = "+string_format(sum[0], 1, 16));
    if (grid1[# i-x_off, j-y_off] < 0) show_debug_message("sum[1] = "+string_format(sum[1], 1, 16));
    if (grid2[# i-x_off, j-y_off] < 0) show_debug_message("sum[2] = "+string_format(sum[2], 1, 16));
    if (grid3[# i-x_off, j-y_off] < 0) show_debug_message("sum[3] = "+string_format(sum[3], 1, 16));
    if (grid4[# i-x_off, j-y_off] < 0) show_debug_message("sum[4] = "+string_format(sum[4], 1, 16));
    if (grid5[# i-x_off, j-y_off] < 0) show_debug_message("sum[5] = "+string_format(sum[5], 1, 16));
    if (grid6[# i-x_off, j-y_off] < 0) show_debug_message("sum[6] = "+string_format(sum[6], 1, 16));
    
    if (grid0[# i-x_off, j-y_off] > 1) show_debug_message("sum[0] = "+string_format(sum[0], 1, 16));
    if (grid1[# i-x_off, j-y_off] > 1) show_debug_message("sum[1] = "+string_format(sum[1], 1, 16));
    if (grid2[# i-x_off, j-y_off] > 1) show_debug_message("sum[2] = "+string_format(sum[2], 1, 16));
    if (grid3[# i-x_off, j-y_off] > 1) show_debug_message("sum[3] = "+string_format(sum[3], 1, 16));
    if (grid4[# i-x_off, j-y_off] > 1) show_debug_message("sum[4] = "+string_format(sum[4], 1, 16));
    if (grid5[# i-x_off, j-y_off] > 1) show_debug_message("sum[5] = "+string_format(sum[5], 1, 16));
    if (grid6[# i-x_off, j-y_off] > 1) show_debug_message("sum[6] = "+string_format(sum[6], 1, 16));
    //*/
    
  }
}


return array_of_cell_grids;
