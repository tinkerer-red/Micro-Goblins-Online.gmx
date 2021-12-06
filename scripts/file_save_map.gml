///file_save_map(filename, map)

var filename = argument0;
var map = argument1;
var buff = buffer_create(64, buffer_grow, 4); 

var _str = json_encode(map)

buffer_write(buff, buffer_string, _str)

buffer_save(buff, filename)

buffer_delete(buff)
