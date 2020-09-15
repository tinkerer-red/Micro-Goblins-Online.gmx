/// gui_set_value(gui,name,value);

var n = ds_list_size(argument0);

var i,item;
for (i = 1; i < n; ++i) {
    item = argument0[| i];
    if item[0] = argument1 {
        if item[1] != 4 item[@2] = clamp(argument2, item[3], item[4]);
        else item[@2] = argument2;
        return true;
    }
}

show_message("gui_get_value: name " + string(argument1) + " don't exist!");