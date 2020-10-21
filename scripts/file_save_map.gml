///file_save_map(filename, map)

var filename = argument0;
var map = argument1;
var buff = buffer_create(64, buffer_grow, 4); 

//var _str = ds_map_write(map)
var _str = json_encode(map)

buffer_write(buff, buffer_string, _str)

buffer_save(buff, filename)

buffer_delete(buff)

/*
file = file_text_open_write(filename);
file_text_write_string(file, _str)
file_text_close(file);
//*/


