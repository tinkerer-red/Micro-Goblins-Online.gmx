randomize(); // Comment this line to get the same output every time. For debug for example.
seed = random_range(65536,6553600);

tileSize = 8; // Size of the tile in px. If sprites are in use, can be changed to sprite_get_width(id).
// Small tileSize is considerably slower. For example at 1px, you will be generating 409600 tiles for 640x640 room.

//DS_MAP with possible script outputs and cooresponding tile numbers. Decoded from JSON string.
//As with all data structures, don't forget to destroy it, to prevent memory leaks.
global.tile_map = json_decode( // 
'{ "254": 45, "90": 22, "22": 7, "0": 47, "10": 3, "2": 1,
 "94": 24, "120": 29, "11": 4, "208": 34, "107": 28, "82": 19,
  "216": 37, "86": 20, "223": 41, "214": 36, "104": 26, "222": 40,
   "74": 16, "18": 6, "8": 2, "248": 42, "255": 46, "127": 33,
    "123": 31, "66": 14, "16": 5, "219": 39, "75": 17, "80": 18,
     "122": 30, "30": 11, "126": 32, "31": 12, "250": 43, "88": 21,
      "64": 13, "95": 25, "251": 44, "91": 23, "24": 8, "27": 10,
       "218": 38, "72": 15, "106": 27, "26": 9, "210": 35 }');

width = room_width / tileSize;
height = room_height / tileSize;

grid = ds_grid_create(width, height); // Main grid for storing noise values.

scr_gen_2dig(8, 0.5, 2, 2.1042, 1, 0); // Octaves, Persistence, Wavelength Modifier, Lacunarity, Is island, Refined and AutoTiled.

/*
V2.0 AUTOTILING INFORMATION

Refined and AutoTiled - ONLY FOR SPRITE TILES. Refines grid to easy-to-use integers. 
For example all from 0 to <0.15 will be modified to 0, all >0.15 to <0.25 to 10. etc.
And then appllies bitmask based autotiling.

Templates for tileset are included in TILESET_TEMPLATES sprite. For straight edges and rounded.

IMPORTANT: My implementation of autotiling isn't protected from all possible generation variants, 
so if for example stone generates near grass or sand there won't be a sprite to place. 
It's possible to just draw tileset for every variant, but that's just waste of time. 
Make terrain zones wider by tinkering with scr_at_refg_2dig outputs and you'll be fine.
Or just make another cleaning check and replace some terrain types with the rigth one, or some custom sprites.

*/

/*
Octaves - How many layers of noise will be summarised for the final output. More octave, more errosion.
Persistence - How fast amplitude of each new octave will diminish. Higher values = more random generation.
Lacunarity - How much frequency of each new octave will increase. Lower values = smoother islands \ terrain.
Is island - If 1, elliptical gradient is applied and island will be generated. If 0, full room terrain will be ganerated.

Wavelenght modifier is basically a Chunk Size. 
At 1 the chunk for generation will be = grid width / 1.
2 = grid width / 2. Etc.
2 - 4 is optimal for good looking islands. 
But if you want more eroded islands or more smaller details for full room terrain, you can try higher numbers.
*/

