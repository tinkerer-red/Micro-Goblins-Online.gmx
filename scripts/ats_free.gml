/// ats_free()
// Frees the resources used by the ATS extension. This should be called when you're no longer using ATS.

ds_grid_destroy(obj_chunk_supervisor.ats_grid_tile_variants);
ds_grid_destroy(obj_chunk_supervisor.ats_a);
ds_grid_destroy(obj_chunk_supervisor.ats_rgb);
