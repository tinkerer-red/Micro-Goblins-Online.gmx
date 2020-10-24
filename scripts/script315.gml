/// Creature Chunk Surface  

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
          
              if (show_chunks) {
                var col = c_white
                //humidity and temp
//                  var col = c_white
//                  var col_red  = section_percent(temperature_grid[#i, j], 4)*63 *4
//                  var col_blue = section_percent(humidity_grid[#i, j], 4)*63 *4
//                  var col = make_colour_rgb(col_red, 255, col_blue)
//                  draw_set_color(col);
                
                //structures
//                var col = c_white
//                  var c_value = section_percent(structures_grid[#i, j], 255)*63 *4
//                    c_value = 255-c_value;
//                    if c_value < 43{
//                      var col = c_black
//                    }
//                    draw_set_color(col);
/*              
                if(heightmap_grid[#i, j] <= 0.15){draw_sprite_ext(tile_water, 0, (i*tile_size), (j*tile_size), 1, 1, 0, col, 1);}
                else if(heightmap_grid[#i, j] > 0.15 && heightmap_grid[#i, j] < 0.25){draw_sprite_ext(tile_sand, 0, i*tile_size, j*tile_size, 1, 1, 0, col, 1);}
                else if(heightmap_grid[#i, j] >= 0.25 && heightmap_grid[#i, j] <= 0.6){draw_sprite_ext(tile_grass, 0, i*tile_size, j*tile_size, 1, 1, 0, col, 1);}
                else if(heightmap_grid[#i, j] > 0.6 && heightmap_grid[#i, j] <= 0.7){draw_sprite_ext(tile_dirt, 0, i*tile_size, j*tile_size, 1, 1, 0, col, 1);}
                else if(heightmap_grid[#i, j] > 0.7 && heightmap_grid[#i, j] <= 0.8){draw_sprite_ext(tile_rock, 0, i*tile_size, j*tile_size, 1, 1, 0, col, 1);}
                else if(heightmap_grid[#i, j] > 0.8){draw_sprite_ext(tile_snow, 0, i*tile_size, j*tile_size, 1, 1, 0, col, 1);}
*/                
                //draw chunk boarders
                var chunk_string = "("+string(chunk_x)+","+string(chunk_y)+")";
                var scale = 1//obj_camera_control.upscale_val/2;
                draw_set_colour(c_yellow)
                draw_rectangle(0, 0, sprite_width, sprite_height, true)
                draw_set_font(font_debug)
                draw_text_transformed(x,y,chunk_string,1*scale, 1*scale, 0)

              }else{ //if debug is off
                
                if(heightmap_grid[#i, j] <= 0.15){draw_sprite(tile_water, 0, (i*tile_size), (j*tile_size));}
                else if(heightmap_grid[#i, j] > 0.15 && heightmap_grid[#i, j] < 0.25){draw_sprite(tile_sand, 0, i*tile_size, j*tile_size);}
                else if(heightmap_grid[#i, j] >= 0.25 && heightmap_grid[#i, j] <= 0.6){draw_sprite(tile_grass, 0, i*tile_size, j*tile_size);}
                else if(heightmap_grid[#i, j] > 0.6 && heightmap_grid[#i, j] <= 0.7){draw_sprite(tile_dirt, 0, i*tile_size, j*tile_size);}
                else if(heightmap_grid[#i, j] > 0.7 && heightmap_grid[#i, j] <= 0.8){draw_sprite(tile_rock, 0, i*tile_size, j*tile_size);}
                else if(heightmap_grid[#i, j] > 0.8){draw_sprite(tile_snow, 0, i*tile_size, j*tile_size);}//*/
              }
              //*
              
              //*/
          }
      
      }
  //*/
  surface_reset_target()                
  }

