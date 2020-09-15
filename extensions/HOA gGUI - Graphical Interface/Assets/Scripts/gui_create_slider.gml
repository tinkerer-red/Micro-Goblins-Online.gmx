/// gui_create_slider(gui,name,default,min,max[,value_color,width,height])
/*
    Create an slider item
    
    name: item name
    default: initial value
    min: minimum value
    max: maximum  value
    
    Optional:
    value_color: value and mark color
    width: item width (omit to use default size)
    height: item height (omit to use default size)
    
    return item reference
*/

var gui = argument[0];
var sets = gui[| 0];

var vcolor,width,height;

if argument_count < 6 vcolor = sets[9];
else vcolor = argument[5];             // value color
if argument_count < 7 width = sets[4];
else width = argument[6];              // width
if argument_count < 8 height = sets[5];
else height = argument[7];             // height

return _gui_create_item(gui, string(argument[1]), 0, argument[2], argument[3], argument[4], vcolor, width, height, -1, 148);