/// gui_create_string(gui,name,string[,value_color,width,height])
/*
    Create a text item
    
    name: item name
    string: value to show
    
    Optional:
    width: item width (omit to use default size)
    height: item height (omit to use default size)
    value_color: value and mark color
    
    return item reference
*/

var gui = argument[0];
var sets = gui[| 0];

var vcolor,width,height;

if argument_count < 4 vcolor = sets[9];
else vcolor = argument[3];             // value color
if argument_count < 5 width = sets[4];
else width = argument[4];             // width
if argument_count < 6 height = sets[5];
else height = argument[5];             // height

return _gui_create_item(argument[0], string(argument[1]), 5, argument[2], "", "", vcolor, width, height, -1, 148);