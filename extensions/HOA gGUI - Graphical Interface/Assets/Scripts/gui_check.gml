/// gui_check(gui,gui_x,gui_y,cx,cy)
/*
    Check interaction with the gui
    
    gui_x, gui_y -> gui position, need to match the draw position
    cx, cy       -> point to test click, need to match where the gui is drawn. For example:
    For the Draw GUI event set:
    cx = mouse_x-view_xview;
    cy = mouse_y-view_yview;
    For the regular Draw event set:
    cx = mouse_x;
    cy = mouse_y;
    
*/

var i, j, n, xx, yy, item, draw;
var sets = argument0[| 0];

n = ds_list_size(argument0);
draw = 0;

xx = 0;
yy = 0;

i = 0;
repeat n order[i++] = 0;

if sets[0] {
    for (i = 1; i < n; ++i) {
        item = argument0[| i];
        
        xx = order[i];
        
        if draw > 0 {
            --draw;
            continue;
        }
        
        gui_item_check(item, argument1+xx, argument2+yy, argument3, argument4, xx);
        
        if item[1] = 2 {
            draw = !item[2] * item[3];
            
            j = i+1;
            repeat item[3] {
                order[j++] += 8;
            }
        
        }
        
        yy += item[6];
    }
}

// Close Controls
if mouse_check_button_pressed(mb_left) && (argument3 > argument1 && argument3 < argument1+sets[4]+sets[6]) && (argument4 > (yy*sets[0]) + argument2 && argument4 < ((yy) * sets[0] )+ argument2 + sets[8]) {
    sets[@0] = !sets[0];
}