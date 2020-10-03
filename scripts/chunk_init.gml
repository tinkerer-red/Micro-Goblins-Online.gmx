///chunk_init(cell_size, chunk_dist)

global.chunk_handler = id

chunk_width = argument0;
chunk_height = argument0;

chunk_dist = argument1;

chunk_center_x = chunk_width/2
chunk_center_y = chunk_height/2

world_name = "World"

chunk_saved_this_frame = false
chunk_loaded_this_frame = false
chunk_gen_this_frame = false

saving_async = ds_priority_create()
loading_async = ds_priority_create()





