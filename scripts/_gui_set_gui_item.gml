///_gui_set_gui_item(guid,item,width,height,value_width,input_width)



var item = argument0[| argument1];

//if item[1] = 2{      // if another list do a recursive loop
//  _gui_set_gui_item(argument0, argument1, argument2, argument3, argument4, argument5)
//}

item[5] = argument2;    // width
item[6] = argument3;    // height

item[9] = argument4;   // value_width
item[10] = argument5;     // numeric value size (sliders)




