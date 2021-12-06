///file_load_map(filename)

var buff = buffer_load(argument0)
var _str = buffer_read(buff, buffer_string)
var map = json_decode(_str)
buffer_delete(buff)

return map;



