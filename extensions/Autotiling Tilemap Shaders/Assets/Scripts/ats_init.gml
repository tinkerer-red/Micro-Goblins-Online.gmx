/// ats_init(tile width, tile height, sprites, max tile variants)
// Initializes Autotiling Tilemap Shaders by letting the user specify the properties of the tiles.
// tile width, tile height: The width and height of the tile. Should be even, positive numbers. E.g. 16x16. This also specifies the format of the tile template (see below).
// sprites: A temporary DS priority with all the tile sprites to be used. The value should be the sprite index, and the priority should be the z (depth) of the sprite. A higher z makes a tile appear behind tiles with a lower z.
// max tile variants: The maximum number of tile variants. The images in a tile sprite will be treated as variants. When a tile is rendered, it will choose a random variant by irandom(max tile variants - 1).
// For more information, you can contact me at "http://goo.gl/BjEPkD" or by sending an email to "asbjorn.lystrup@gmail.com".

/*
    Tile template:

    +---+---+---+---+---+   You should look at the example template; spr_example_tile_template for a better understanding, what's below is more of a detailed description.
    |TLO| T | T |TRO|TRI|   Each cell in the grid to the left represent the different parts that can make up a tile. If your tile is 16x16 in size, each cell to the left is 8x8 (half the width and height).
    +---+---+---+---+---+   C: The center part of the tile. This is the part that's repeated if you place tiles next to each other. In other words the fill, the only part that is not an edge.
    | L | C | C | R |BRI|   R, T, L, B: The right, top, left and bottom edge of the tile. These will be added around the center part of the tile in game.
    +---+---+---+---+---+   TRO, TLO, BLO, BRO: The outer corners; the top right, top left, bottom left, and bottom right, respectively. If a tile has no other tiles around it, it will have all 4 outer corners.
    | L | C | C | R |TLI|   TRI, BRI, TLI, BLI: The inner corners; the top right, bottom right, top left, and bottom left, respectively. If two tiles are alone and diagonally next to each other,
    +---+---+---+---+---+   two inner corners will be created in the area where the tiles meet.
    |BLO| B | B |BRO|BLI|
    +---+---+---+---+---+
*/

global.ats_tile_width = argument0; global.ats_tile_height = argument1;
var priority = argument2;
global.ats_tile_variants_max = argument3;

global.ats_tile_width_half = global.ats_tile_width * 0.5; global.ats_tile_height_half = global.ats_tile_height * 0.5;
global.ats_texture_tiles = sprite_get_texture(ds_priority_find_min(priority), 0);
global.ats_texture_tiles_texel_width = texture_get_texel_width(global.ats_texture_tiles); global.ats_texture_tiles_texel_height = texture_get_texel_height(global.ats_texture_tiles);
global.ats_texture_tiles_width = round(1 / global.ats_texture_tiles_texel_width); global.ats_texture_tiles_height = round(1 / global.ats_texture_tiles_texel_height);
global.ats_sprite_width = global.ats_tile_width_half * 5; global.ats_sprite_height = global.ats_tile_height_half * 4;
global.ats_uniform_sh_ats_0_texel_size = shader_get_uniform(sh_ats_0, "texel_size");
global.ats_uniform_sh_ats_1_texture_tiles = shader_get_sampler_index(sh_ats_1, "texture_tiles");
global.ats_uniform_sh_ats_1_precalculated_0 = shader_get_uniform(sh_ats_1, "precalculated_0");
global.ats_uniform_sh_ats_1_precalculated_1 = shader_get_uniform(sh_ats_1, "precalculated_1");
global.ats_uniform_sh_ats_1_texture_quads = shader_get_sampler_index(sh_ats_1, "texture_quads");

var list = ds_list_create(), last = 0, tile;
repeat (ds_priority_size(priority)) {
    tile = ds_priority_find_min(priority); if (tile > last) last = tile;
    ds_list_add(list, tile, ds_priority_find_priority(priority, ds_priority_find_min(priority)));
    ds_priority_delete_min(priority);
}
global.ats_a = ds_grid_create(last + 1, 1); global.ats_rgb = ds_grid_create(last + 1, global.ats_tile_variants_max);

// Looks through the DS priority and precalculates data representing uvs and z (depth) for the different tile sprites.
var z_index = 0, z, z_previous = list[| 1], z_index_byte, uvs, sprite, width = global.ats_texture_tiles_width / global.ats_sprite_width, height = global.ats_texture_tiles_height / global.ats_sprite_height,
    tile, i, j, size = ds_list_size(list);
for (j = 0; j < size; j += 2) {
    tile = list[| j];
    z = list[| j + 1];
    if (z != z_previous) {++z_index; z_previous = z;}
    global.ats_a[# tile, 0] = (z_index & 255) / 255;
    z_index_byte = (z_index & 65280) * 65536;
    for (i = 0; i < global.ats_tile_variants_max; ++i) {
        uvs = sprite_get_uvs(tile, i);
        global.ats_rgb[# tile, i] = z_index_byte + floor(uvs[1] * height) * 256 + floor(uvs[0] * width);
    }
}
ds_list_destroy(list);

// Creates a grid of random numbers for the tile variants.
random_set_seed(99999989);
global.ats_grid_tile_variants = ds_grid_create(64, 64);
var tile_variants_max_minus_one = global.ats_tile_variants_max - 1;
for (var t_y = 0; t_y < 64; ++t_y) for (var t_x = 0; t_x < 64; ++t_x) {
    global.ats_grid_tile_variants[# t_x, t_y] = irandom(tile_variants_max_minus_one);
}
