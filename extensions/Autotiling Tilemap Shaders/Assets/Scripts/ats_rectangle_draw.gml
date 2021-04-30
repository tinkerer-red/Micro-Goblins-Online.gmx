/// ats_rectangle_draw(ATS rectangle instance, DS grid, tile x, tile y, width, height, x, y)
// Visualizes the tiles over the grid region specified by tile x, tile y, width and height.
// ATS rectangle instance: The rectangle instance to use.
// DS grid: A DS grid representing how the tiles are layed out over the rectangle. Each cell of the grid should hold the tile sprite to be used for that tile. The size of the grid should be the same a the number of tiles
//          horizontally and vertically in the ATS rectangle instance. The reason it has to be entered for the draw function is in case the surfaces don't exist and have to be created.
// tile x, tile y: The position of the region within the grid to visualize. Set this to undefined if you want to draw everything.
// width, height: The size of the region to visualize. Set this to undefined if you want to draw everything.
// x, y: The position to draw the rectangle at (top left corner).

with (argument0) {
    if (is_undefined(argument2)) argument2 = 0;
    if (is_undefined(argument3)) argument3 = 0;
    if (is_undefined(argument4)) argument4 = width_tiles;
    if (is_undefined(argument5)) argument5 = height_tiles;

    if (!surface_exists(sf_0)) {
        // We draw the precalculated data from ats_init onto the first surface, sf_0, which holds uv and z (depth) information in its channels.
        sf_0 = surface_create(width_tiles, height_tiles);
        surface_set_target(sf_0);
            draw_enable_alphablend(false);
                var t_y, t_x, width = width_tiles, height = height_tiles, a = global.ats_a, rgb = global.ats_rgb, tile,
                    tile_variants_max_minus_one = global.ats_tile_variants_max - 1, random_value, grid_tile_variants = global.ats_grid_tile_variants;
                for (t_y = 0; t_y < height; ++t_y) {
                    for (t_x = 0; t_x < width; ++t_x) {
                        tile = argument1[# t_x, t_y];
                        draw_set_alpha(a[# tile, 0]);
                        draw_point_color(t_x, t_y, rgb[# tile, grid_tile_variants[# t_x & 63, t_y & 63] % tile_variants_max_minus_one]);
                    }
                }
            draw_enable_alphablend(true);
            draw_set_alpha(1);
        surface_reset_target();
    }

    if (!surface_exists(sf_1)) {
        // We draw sf_0 to sf_1 with the first shader, sh_ats_0, which calculates and stores the instructions for how the edges will be drawn later.
        sf_1 = surface_create(width_tiles, height_tiles);
        surface_set_target(sf_1);
            draw_enable_alphablend(false); texture_set_interpolation(false);
                shader_set(sh_ats_0);
                    shader_set_uniform_f(global.ats_uniform_sh_ats_0_texel_size, sf_texel_width, sf_texel_height);
                    draw_surface(sf_0, 0, 0);
                shader_reset();
            texture_set_interpolation(true); draw_enable_alphablend(true);
        surface_reset_target();
    }

    // Draws the actual tiles.
    texture_set_interpolation(false);
        shader_set(sh_ats_1);
            texture_set_stage(global.ats_uniform_sh_ats_1_texture_tiles, global.ats_texture_tiles);
            shader_set_uniform_f(global.ats_uniform_sh_ats_1_precalculated_0, width_px, height_px, global.ats_texture_tiles_texel_width, global.ats_texture_tiles_texel_height);
            shader_set_uniform_f(global.ats_uniform_sh_ats_1_precalculated_1, sf_texel_width, sf_texel_height, global.ats_tile_width, global.ats_tile_height);
            texture_set_stage(global.ats_uniform_sh_ats_1_texture_quads, surface_get_texture(sf_1));
            if (surface_optimization_enabled) {
                if (!surface_exists(sf_optimization)) {sf_optimization = surface_create(width_px, height_px); sf_optimization_update = true;}
                if (sf_optimization_update) {
                    sf_optimization_update = false;
                    draw_enable_alphablend(false);
                        surface_set_target(sf_optimization);
                            draw_surface_ext(sf_0, 0, 0, global.ats_tile_width, global.ats_tile_height, 0, c_white, 1);
                        surface_reset_target();
                    draw_enable_alphablend(true);
                }
            } else {
                draw_set_blend_mode_ext(bm_one, bm_inv_src_alpha);
                    draw_surface_part_ext(sf_0, argument2, argument3, argument4, argument5, argument6, argument7, global.ats_tile_width, global.ats_tile_height, c_white, 1);
                draw_set_blend_mode(bm_normal);
            }
        shader_reset();
    texture_set_interpolation(true);

    if (surface_optimization_enabled) {
        draw_set_blend_mode_ext(bm_one, bm_inv_src_alpha);
            draw_surface_part(sf_optimization, argument2 * global.ats_tile_width, argument3 * global.ats_tile_height, argument4 * global.ats_tile_width, argument5 * global.ats_tile_height, argument6, argument7);
        draw_set_blend_mode(bm_normal);
    }
}
