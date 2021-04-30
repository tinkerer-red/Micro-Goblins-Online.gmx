/// ats_rectangle_create(tiles horizontally, tiles vertically, surface optimization)
// Creates an instance for a rectangular area to visualize tiles within. If your game has a chunk system, you can create a rectangle instance per chunk.
// tiles horizontally, tiles vertically: The number of tiles for the rectangle to cover horizontally and vertically. In other words the width and height of the rectangle in terms of tiles.
// surface optimization: Setting this to true will make the rectangle only use the shader sh_ats_1 when necessary by drawing the result to a surface whenever that shader is used. This might require a lot of VRAM though.

var instance = instance_create(0, 0, obj_ats_rectangle);

with (instance) {
    width_tiles = argument0; height_tiles = argument1;
    surface_optimization_enabled = argument2;
    
    if (surface_optimization_enabled) {sf_optimization = -1; sf_optimization_update = false;}
    width_px = width_tiles * global.ats_tile_width; height_px = height_tiles * global.ats_tile_height;
    sf_0 = -1; sf_1 = -1;
    sf_texel_width = 1 / width_tiles; sf_texel_height = 1 / height_tiles;
}

return instance;
