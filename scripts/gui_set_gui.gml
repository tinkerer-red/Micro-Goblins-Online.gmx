/// gui_set_gui(gui,width,height,value_width,intup_width,margin,);
/*
    Set default values for gui
    Use it before creating items
    
    gui         -> gui id
    width  -> width of the name column
    height      -> height of the item
    value_width -> width of the value column
    input_width -> width of the numeric field in sliders
    margin      -> margin offset
*/

var i = 0
var sets = argument0[| 0];

repeat(ds_list_size(argument0)){
var item = argument0[| i];

  if i = 0 { 
    //sets[0] = 1;                        // opened/closed
    sets[1] = argument4;  // numeric field width (input for slider)
    //sets[2] = "Open Debug Controls"                     // name of the button to open gui
    //sets[3] = "Close Debug Controls";                   // name of the button to close gui
    sets[4] = argument1; // name column width
    sets[5] = argument2;  // name/value column height
    sets[6] = argument3; // value column width    ///this value does absolutely nothing
    sets[7] = argument5;   // margin
    sets[8] = argument2;  // open/close button height
    
    array_copy(argument0[| 0], 0, sets, 0, array_length_1d(argument0[| 0]))
  }else{
    item[11] = sets[7];     // margin
    
    item[5] = sets[4];    // width
    item[6] = sets[5];    // height
    item[9] = sets[6];   // value_width
    item[10] = sets[1];     // numeric value size (sliders)
    array_copy(argument0[| i], 0, item, 0, array_length_1d(argument0[| i]))
  }
  i++
}
