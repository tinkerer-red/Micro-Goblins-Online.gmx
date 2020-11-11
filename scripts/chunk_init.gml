///chunk_init(cell_size, chunk_dist)

global.chunk_handler = id;

chunk_width = argument0;
chunk_height = argument0;

tile_size = 16;

chunk_dist = argument1;
margin = 2;

chunk_center_x = chunk_width/2
chunk_center_y = chunk_height/2

world_name = "World"

world_width  = 16*16*128  //131072 16*16*512   //tileSize * chunkSize * number of chunks
world_height = 16*16*128  //131072 16*16*512

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
  world_seed = random_range(65536,6553600);
  world_map[? "Seed"] = world_seed;
}

world_heightmap = gpu_noise_create_ext(0, world_seed, 16, 16, 0.0000001, 0.0625, 2.0)//0.001)

active_chunks = ds_map_create()



