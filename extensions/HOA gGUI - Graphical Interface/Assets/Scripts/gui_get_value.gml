/// gui_get_value(gui_array,name);

var n = ds_list_size(argument0);

var i,item;
for (i = 1; i < n; ++i) {
    item = argument0[| i];
    if item[0] = argument1 return item[2];
}

show_message("gui_get_value: name " + string(argument1) + " don't exist!");