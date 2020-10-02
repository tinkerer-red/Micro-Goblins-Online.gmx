///chunk_init(cell_size, chunk_dist)

global.chunk_handler = id

chunk_width = argument0;
chunk_height = argument0;

chunk_dist = argument1;

chunk_center_x = chunk_width/2
chunk_center_y = chunk_height/2

world_name = "World"

saving_async = ds_priority_create()
save_pointer = 0
loading_async = ds_priority_create()
load_pointer = 0


