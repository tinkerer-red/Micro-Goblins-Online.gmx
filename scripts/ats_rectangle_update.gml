/// ats_rectangle_update(ATS rectangle instance, DS grid, tile x, tile y, width, height)
// Updates the surface values over a specified region of the ATS rectangle.
// ATS rectangle instance: The rectangle instance to use.
// DS grid: A DS grid representing how the tiles are layed out over the rectangle. Each cell of the grid should hold the tile sprite to be used for that tile. The size of the grid should be the same as the number of tiles
//          horizontally and vertically in the ATS rectangle instance.
// tile x, tile y: The position of the region within the grid to update.
// width, height: The size of the region to update.

with (argument0) {
    // Inexistent surfaces are automatically created before being drawn, so we can ignore the update if they don't exist.
    if (surface_exists(sf_0) && surface_exists(sf_1)) {
        draw_enable_alphablend(false);
            
            // We draw the precalculated data from ats_init onto the first surface, sf_0, which holds uv and z (depth) information in its channels.
            surface_set_target(sf_0);
                draw_clear_alpha(c_white,0)
                var t_y_end = argument3 + argument5 - 1,
                    t_x_end = argument2 + argument4 - 1,
                    a = obj_chunk_supervisor.ats_a,
                    rgb = obj_chunk_supervisor.ats_rgb, tile,
                    tile_variants_max_minus_one = obj_chunk_supervisor.ats_tile_variants_max - 1,
                    grid_tile_variants = obj_chunk_supervisor.ats_grid_tile_variants;
                    
                for (var t_y = argument3; t_y <= t_y_end; ++t_y) {
                    for (var t_x = argument2; t_x <= t_x_end; ++t_x) {
                        tile = argument1[# t_x, t_y];
                        draw_set_alpha(a[# tile, 0]);
                        draw_point_color(t_x, t_y, rgb[# tile, grid_tile_variants[# t_x & 63, t_y & 63] % tile_variants_max_minus_one]);
                    }
                }
                draw_set_alpha(1);
            surface_reset_target();

            // We draw sf_0 to sf_1 with the first shader, sh_ats_0, which calculates and stores the instructions for how the edges will be drawn later.
            surface_set_target(sf_1);
              draw_clear_alpha(c_white,0)
                 texture_set_interpolation(false);
                    shader_set(sh_ats_0);
                        shader_set_uniform_f(obj_chunk_supervisor.ats_uniform_sh_ats_0_texel_size, sf_texel_width, sf_texel_height);
                        draw_surface_part(sf_0, argument2 - 1, argument3 - 1, argument4 + 2, argument5 + 2, argument2 - 1, argument3 - 1);
                    shader_reset();
                texture_set_interpolation(true);
            surface_reset_target();

            if (surface_optimization_enabled) sf_optimization_update = true;
            
        draw_enable_alphablend(true);
    }
}
