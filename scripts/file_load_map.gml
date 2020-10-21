///file_load_map(filename)

var buff = buffer_load(argument0)
var _str = buffer_read(buff, buffer_string)
var map = json_decode(_str)
buffer_delete(buff)

return map;

/*
var file = file_text_open_read(argument0)
var _str = file_text_read_string(file);
file_text_close(file);
//ds_map_read(argument1, _str);
var map = json_decode(_str)

return map;

