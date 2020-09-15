/// gui_set_gui(gui,value_color,name_width,height,value_width,intup_width,margin,open,open_name,close_name,open_height);
/*
    Set default values for gui
    Use it before creating itens
    
    gui         -> gui id
    value_color -> color for controls and values
    name_width  -> width of the name column
    height      -> height of the item
    value_width -> width of the value column
    intup_width -> width of the numeric field in sliders
    margin      -> margin offset
    open        -> true/false
    open_name   -> text for the open button
    close_name  -> text for the close button
    open_height -> height for the button
*/

var sets = argument0[| 0];

sets[0] = argument7;  // opened/closed
sets[1] = argument5;  // numeric field width (slider)
sets[2] = argument8;  // name of the button to open gui
sets[3] = argument9;  // name of the button to close gui
sets[4] = argument2;  // name column width
sets[5] = argument3;  // height
sets[6] = argument4;  // value column width
sets[7] = argument6;  // margin
sets[8] = argument10; // open/close button height
sets[9] = argument1;  // value color