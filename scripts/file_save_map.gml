///file_save_map(filename, map)

var filename = argument0;
var map = argument1;

//var _str = ds_map_write(map)
var _str = json_encode(map)

file = file_text_open_write(filename);
file_text_write_string(file, _str)
file_text_close(file);



