/// gui_draw(gui,x,y)

var i, j, n, xx, yy, item, draw;

n = ds_list_size(argument0);

var sets = argument0[| 0];
draw = 0;

xx = -8;
yy = 0;

draw_set_valign(fa_middle);

i = 0;
repeat n order[i++] = 0;

if sets[0] != 0 {
    for (i = 1; i < n; ++i) {
        item = argument0[| i];
        
        xx = order[i];
        
        if draw > 0 {
            --draw;
            continue;
        }
        
        gui_item_draw(item, argument1+xx, argument2+yy, xx);
        
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

xx = 0;

draw_set_color(c_black);
draw_rectangle(argument1+xx-8, argument2+yy+1, argument1+xx+(sets[4]+sets[6])+8+1, argument2+yy+sets[8], 0);

draw_set_color($eeeeee);
draw_set_halign(fa_center);
draw_text(argument1+xx-8 + ((sets[4]+sets[6])+8+1)/2, argument2+yy+1 + sets[8]/2, sets[2+sets[0]]);
draw_set_halign(fa_left);

draw_set_valign(fa_top);