/// gui_create_menu(gui,name,default,item_n[,value_color,width,height])
/*
    Create a menu to group items
    
    name: item name
    default: open/closed
    item_n: sequential number of item to group in this menu
    
    Optional:
    value_color: value and mark color
    width: item width (omit to use default size)
    height: item height (omit to use default size)
    
    return item reference
*/

var gui = argument[0];
var sets = gui[| 0];

var vcolor,width,height;

if argument_count < 5 vcolor = sets[9];
else vcolor = argument[4];             // value color
if argument_count < 6 width = sets[4];
else width = argument[5];             // width
if argument_count < 7 height = sets[5];
else height = argument[6];             // height

return _gui_create_item(argument[0], string(argument[1]), 2, argument[2], argument[3], argument[3], vcolor, width, height, -1, 148);