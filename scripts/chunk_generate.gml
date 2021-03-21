///chunk_generate()

//should be called only by the chunk it's self

// let future scripts know this is a new cell, to prevent map comparasons.
generated = true;


heightmap_grid = scr_gen_2dig(3, 0.6, 0.8, 2.1042, 1, 0, 0.6); // Octaves, Persistence, Wavelength Modifier, Lacunarity, Is island, Refined and AutoTiled, elliptical gradient percent
structure_grid = scr_gen_2dig_dungeons()
//obsticals_grid = 


