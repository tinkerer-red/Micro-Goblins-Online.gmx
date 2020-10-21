
if variable_instance_exists(id, "terrain_surface") && surface_exists(terrain_surface){
  draw_set_alpha(1)
  draw_surface(terrain_surface, x, y)
  
}else{
  
  var tile_size = global.chunk_handler.tile_size
  var width  = global.chunk_handler.world_width
  var height = global.chunk_handler.world_height
  
  var x_off = bbox_left/tile_size;
  var y_off = bbox_top/tile_size;
  
  terrain_surface = surface_create(sprite_width, sprite_height)
  
  if(ds_grid_get_max(heightmap_grid, 0,0,width,height) <=1){ // If max value of our grid is less or equal 1, then poceed without autotiling.
  
  surface_set_target(terrain_surface)
  //*
  for(var i = 0; i < sprite_width/tile_size; i++){
      for(var j = 0; j < sprite_height/tile_size; j++){
          
              // Comment this part ↓ and uncomment "Tile gen" part for use of sprites in generation.
  //            draw_set_color(scr_zcolor_2dig(heightmap_grid[# i, j]));
  //            draw_rectangle(x+i*tile_size, y+j*tile_size, x+(i + 1)* tile_size, y+(j + 1)* tile_size, false);
              
              // Tile gen ↓ . Don't forget to set tile_size to the sprite size (8 for included sprites).
              //*
              var col = c_white
              
              if (show_chunks) {
                //humidity and temp
                /*
                  var col = c_white
                  var col_red  = section_percent(temperature_grid[#i, j], 4)*63 *4
                  var col_blue = section_percent(humidity_grid[#i, j], 4)*63 *4
                  var col = make_colour_rgb(col_red, 255, col_blue)
                  draw_set_color(col);
                */
                
                //structures
                var col = c_white
                  var c_value = section_percent(structures_grid[#i, j], 255)*63 *4
                    c_value = 255-c_value;
                    if c_value < 43{
                      var col = c_black
                    }
                    draw_set_color(col);
              }
              
              if(heightmap_grid[#i, j] <= 0.15){draw_sprite_ext(tile_water, 0, (i*tile_size), (j*tile_size), 1, 1, 0, col, 1);}
              else if(heightmap_grid[#i, j] > 0.15 && heightmap_grid[#i, j] < 0.25){draw_sprite_ext(tile_sand, 0, i*tile_size, j*tile_size, 1, 1, 0, col, 1);}
              else if(heightmap_grid[#i, j] >= 0.25 && heightmap_grid[#i, j] <= 0.6){draw_sprite_ext(tile_grass, 0, i*tile_size, j*tile_size, 1, 1, 0, col, 1);}
              else if(heightmap_grid[#i, j] > 0.6 && heightmap_grid[#i, j] <= 0.7){draw_sprite_ext(tile_dirt, 0, i*tile_size, j*tile_size, 1, 1, 0, col, 1);}
              else if(heightmap_grid[#i, j] > 0.7 && heightmap_grid[#i, j] <= 0.8){draw_sprite_ext(tile_rock, 0, i*tile_size, j*tile_size, 1, 1, 0, col, 1);}
              else if(heightmap_grid[#i, j] > 0.8){draw_sprite_ext(tile_snow, 0, i*tile_size, j*tile_size, 1, 1, 0, col, 1);}//*/
              //*
              
              //*/
          }
      
      }
  //*/
  surface_reset_target()                
  }
}
