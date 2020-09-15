/// gui_item_check(item,item_x,item_y,cx,cy,offset)
/*
    Check interaction with a single item
    
    item -> item reference
    item_x, item_y -> item position, need to match the draw position
    
    cx, cy       -> point to test click, need to match where the item is drawn. For example:
    For the Draw GUI event set:
    cx = mouse_x-view_xview;
    cy = mouse_y-view_yview;
    For the regular Draw event set:
    cx = mouse_x;
    cy = mouse_y;
    
    offset -> offset of nested menus
    
*/

var nwidth = argument0[5]-argument5;
var nheight = argument0[6];
var vwidth = argument0[9];
var margin = argument0[11];

var w = argument0[10];

if mouse_check_button_pressed(mb_left) && (argument4 > argument2 && argument4 < argument2+nheight) {

    switch (argument0[1]) {
        case 0:
            // value, and slider

            // slider
            if (argument3 > argument1+nwidth && argument3 < argument1+nwidth+vwidth-w-margin) {
                argument0[@8] = 0;
            }
            
            // value
            if (argument3 > argument1+nwidth+vwidth-w && argument3 < argument1+nwidth+vwidth) {
                argument0[@8] = 1;
            }
        break;
        
        case 1:
            // checkbox
            
            if (argument3 > argument1+nwidth && argument3 <  argument1+nwidth+nheight-margin*2) {
                argument0[@2] = !argument0[2];
                argument0[@8] = -1;
            }
        break;
        
        case 2:
            // menu
            if (argument3 > argument1 && argument3 < argument1+nwidth+vwidth) {
                argument0[@2] = !argument0[2];
                argument0[@8] = -1;
            }
        break;
        
        case 3:
            // button
            if (argument3 > argument1 && argument3 < argument1+nwidth+vwidth) {
                script_execute(argument0[2]);
                argument0[@8] = -1;
            }
        break;
        
        case 6:
            // color
            if (argument3 > argument1 && argument3 < argument1+nwidth+vwidth) {
                argument0[@8] = 2;
            }
        break;
    }
}
if mouse_check_button_released(mb_left) && argument0[8] != 2 argument0[@8] = -1;

// Slider
if argument0[8] = 0 {
    var a = clamp((argument3 - (argument1+nwidth))/((argument1+nwidth+vwidth-w-margin) - (argument1+nwidth)),0,1);
    argument0[@2] = lerp(argument0[3], argument0[4], a);
}
if argument0[8] = 1 {
    argument0[@2] = clamp(get_integer(argument0[0], argument0[2]), argument0[3], argument0[4]);
    argument0[@8] = -1;
}
if argument0[8] = 2 {
    if mouse_check_button_pressed(mb_left) {
        argument0[@2] = irandom(c_white);
        //argument0[@8] = -1;
        /*if point_in_rectangle(argument3, argument4, argument1+nwidth, argument2+nheight, argument1+nwidth+100, argument2+nheight+100) {
            
        }*/
    }
}