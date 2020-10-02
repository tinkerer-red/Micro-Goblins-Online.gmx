//destroy everything associated with you from the memory
//delete them in reverse order
//background_flush(tunnel_gfx);
//no point in saving yourself if you're empty
if (empty==false)
chunkSaveToDisk(id);

background_delete(tunnel_gfx);
ds_grid_destroy(tunnel_data);

instance_destroy();
