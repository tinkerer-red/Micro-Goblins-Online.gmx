/// _gui_create_item(gui,name,type,default,min,max,value_color,width,height,mode,value_width)
// internal

var sets = argument0[| 0];

var item;
item[11] = sets[7];     // margin

item[0] = argument1;    // name
item[1] = argument2;    // type
item[2] = argument3;    // value
item[3] = argument4;    // min
item[4] = argument5;    // max
item[5] = argument7;    // width
item[6] = argument8;    // height
item[7] = argument6;    // value color
item[8] = argument9;    // mode
item[9] = argument10;   // value_width
item[10] = sets[1];     // numeric value size (sliders)

ds_list_add(argument0, item);

return item;