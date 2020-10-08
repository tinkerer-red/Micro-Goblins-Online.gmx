///file_save_map_async(file, map)

// returns async id

// Create Buffer to save ansynchronously
var buff = buffer_create(128,buffer_grow,4);
//var async_array;
var map = argument1;

var returned = ds_map_secure_save_buffer(map, buff);
ds_map_destroy(returned)

//if ds_exists(returned, ds_type_map) show_debug_message("It's a MAP!")
//var json = json_encode(returned)
//show_debug_message(json)

async_array[1] = buff;
async_array[0] = buffer_save_async(buff, argument0, 0, buffer_get_size(buff));
//show_debug_message("buffer we should be deleting = "+string(async_array[1]))

return async_array;
