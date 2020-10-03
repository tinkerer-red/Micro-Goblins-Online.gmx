///file_save_map_async(file, map)

// returns async id

// Create Buffer to save ansynchronously
var buff = buffer_create(128,buffer_grow,4);
var async_array;

ds_map_secure_save_buffer(argument1, buff);

async_array[1] = buff;
async_array[0] = buffer_save_async(buff, argument0, 0, buffer_get_size(buff));
//show_debug_message("File save location = "+argument0)

return async_array;
