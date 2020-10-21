if(ds_grid_get_max(grid, 0,0,width,height) <=1){ // If max value of our grid is less or equal 1, then poceed without autotiling.

    for(var i = 0; i < width; i++){
    
        for(var j = 0; j < height; j++){
        
            // Comment this part ↓ and uncomment "Tile gen" part for use of sprites in generation.
            draw_set_color(scr_zcolor_2dig(grid[# i, j]));        
            draw_rectangle(i*tileSize, j*tileSize, (i + 1)* tileSize, (j + 1)* tileSize, false);
            
            // Tile gen ↓ . Don't forget to set tileSize to the sprite size (8 for included sprites).
            /*if(grid[#i, j] <= 0.15){draw_sprite(spr_water_2dig, 0, i*tileSize, j*tileSize);}
            else if(grid[#i, j] > 0.15 && grid[#i, j] < 0.25){draw_sprite(spr_sand_2dig, 0, i*tileSize, j*tileSize);}
            else if(grid[#i, j] >= 0.25 && grid[#i, j] <= 0.6){draw_sprite(spr_grass_2dig, 0, i*tileSize, j*tileSize);}
            else if(grid[#i, j] > 0.6 && grid[#i, j] <= 0.7){draw_sprite(spr_dirt_2dig, 0, i*tileSize, j*tileSize);}
            else if(grid[#i, j] > 0.7 && grid[#i, j] <= 0.8){draw_sprite(spr_stone_2dig, 0, i*tileSize, j*tileSize);}
            else if(grid[#i, j] > 0.8){draw_sprite(spr_snow_2dig, 0, i*tileSize, j*tileSize);}*/       
    
        }
    
    }        
                
} else { // Else autotile.

    for(var i = 0; i < width; i++){
    
        for(var j = 0; j < height; j++){  
             
            terrainType = grid[#i,j];
            if(terrainType == 0){
                draw_sprite(spr_water_2dig, 0,i * tileSize,j * tileSize);
            } 
            else if(terrainType == 10){
                draw_sprite(spr_at_water_sand_2dig, scr_at_bm_2dig(i, j, terrainType),i * tileSize,j * tileSize);     
            }
            else if(terrainType == 20){
                draw_sprite(spr_at_sand_grass_2dig, scr_at_bm_2dig(i, j, terrainType),i * tileSize,j * tileSize);
            }
            else if(terrainType == 30){
                draw_sprite(spr_at_grass_dirt_2dig, scr_at_bm_2dig(i, j, terrainType),i * tileSize,j * tileSize); 
            }
            else if(terrainType == 40){
                draw_sprite(spr_at_dirt_stone_2dig, scr_at_bm_2dig(i, j, terrainType),i * tileSize,j * tileSize);
            }
            else if(terrainType == 50){
                draw_sprite(spr_at_stone_snow_2dig, scr_at_bm_2dig(i, j, terrainType),i * tileSize,j * tileSize);   
            }
        
        }
        
    }

}
