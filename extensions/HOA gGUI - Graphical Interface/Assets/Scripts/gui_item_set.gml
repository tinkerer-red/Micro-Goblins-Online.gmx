/// gui_item_set(item,name,type,default,min,max,value_color,width,height,value_width,intup_width,margin)
/*
    Change setting of an item
    
    0item        -> item reference
    1name        -> text for the name
    2type        -> 0 - slider, 1 - checkbox, 2 - menu, 3 - button, 4 - watcher, 5 - string
    3default     -> initial value
    4min         -> minimum value
    5max         -> maximum  value
    6value_color -> color for controls and values
    7name_width  -> width of the name column
    8height      -> height of the item
    9value_width -> width of the value column
    10intup_width -> width of the numeric field in sliders
    11margin      -> margin offset
*/

var item = argument0;
item[11] = argument11;  // margin

item[0] = argument1;    // name
item[1] = argument2;    // type
item[2] = argument3;    // value
item[3] = argument4;    // min
item[4] = argument5;    // max
item[5] = argument7;    // width
item[6] = argument8;    // height
item[7] = argument6;    // value color
item[8] = -1;           // mode
item[9] = argument9;    // value_width
item[10] = argument10;  // numeric value size (sliders)