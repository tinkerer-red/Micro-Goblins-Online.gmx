///chunk_init(cell_size, chunk_dist)

global.chunk_handler = id;

chunk_width = argument0;
chunk_height = argument0;

tile_size = 16;

chunk_dist = argument1;
margin = 4;

chunk_center_x = chunk_width/2
chunk_center_y = chunk_height/2

interior_zone_size = 16

world_name = "World"

world_width  = chunk_width*128  //131072 16*16*512   //tileSize * chunkSize * number of chunks
world_height = chunk_height*128  //131072 16*16*512

 world_chunk_width = global.chunk_handler.world_width div global.chunk_handler.chunk_width
world_chunk_height = global.chunk_handler.world_height div global.chunk_handler.chunk_height

/* World Sizes
small = 16*16*128 (1 minute to cross at max speed)
med = 16*16*256 (2 minutes)
large = 16*16*512
extra large
*/
chunk_saved_this_frame = false
chunk_loaded_this_frame = false
chunk_gen_this_frame = false

//load world file

var _filename = "Worlds\"+string(world_name)+".map"
if (file_exists(_filename)){
  world_map = file_load_map(_filename)
}else{
  world_map = ds_map_create()
}


//Set seed
if ds_map_exists(world_map, "Seed"){
  world_seed = world_map[? "Seed"];
}else{ //if the seed doesnt exists
  randomize(); // Comment this line to get the same output every time. For debug for example.
  world_seed = irandom_range(65536,6553600);
  world_map[? "Seed"] = world_seed;
}

//world_heightmap = gpu_noise_create_ext(2, world_seed, 16, 16, 0.5, 0.5, 0.5)//0.001)

active_chunks = ds_map_create()
active_interior_chunks = ds_map_create()




