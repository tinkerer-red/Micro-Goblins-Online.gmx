/// gui_item_draw(item,x,y,offset)
/*
    Draw a single item
*/

var nwidth = argument0[5]-argument3;
var nheight = argument0[6];
var vwidth = argument0[9];
var margin = argument0[11];

// background
if argument0[1] = 2 draw_set_color(c_black);
else {
    if argument0[1] = 3 draw_set_color($3f3f3f);
    else draw_set_color($1a1a1a);
}

draw_rectangle(argument1, argument2, argument1+nwidth+vwidth, argument2+nheight,0);

// outline
draw_set_color($2c2c2c);
draw_rectangle(argument1, argument2, argument1+nwidth+vwidth, argument2+nheight,1);

var w = argument0[10];

// value background
switch (argument0[1]) {
    case 0:
        // slider
        draw_rectangle(argument1+nwidth+vwidth-w, argument2+margin, argument1+nwidth+vwidth-margin, argument2+nheight-margin, 0);
    break;
    
    case 1:
        // checkbox
        draw_rectangle(argument1+nwidth, argument2+margin, argument1+nwidth+nheight-margin*2, argument2+nheight-margin, 0);
        
        if argument0[2] {
            draw_set_color(argument0[7]);
            var o = 2;
            draw_rectangle(argument1+nwidth+o, argument2+margin+o, argument1+nwidth+nheight-margin*2-o, argument2+nheight-margin-o, 0);
        }
    break;
    
    case 2:
        // menu
        draw_set_color($eeeeee);
        draw_set_halign(fa_center);
        draw_text_transformed(10+argument1, argument2 + (nheight/2), ">", 1, 1, 270*argument0[2]);
        draw_set_halign(fa_left);
    break;
    
    case 6:
        // color
        /*draw_set_color(argument0[2]);
        draw_rectangle(argument1+nwidth, argument2+margin, argument1+nwidth+vwidth-margin, argument2+nheight-margin, 0);
        
        if colour_get_value(argument0[2]) < 128 draw_set_color(c_white);
        else draw_set_color(c_black);
        draw_text(argument1+nwidth + vwidth/2 - string_width(string(argument0[2]))/2, argument2 + (nheight/2), argument0[2]);
        
        if !instance_exists(objGGUIColorPicker) instance_create(argument1, argument2, objGGUIColorPicker);
        objGGUIColorPicker.item = argument0;
        objGGUIColorPicker.x = argument1;
        objGGUIColorPicker.y = argument2;*/
    break;
}

draw_set_color(argument0[7]);

// mark
draw_rectangle(argument1, argument2+1, argument1+margin, argument2+nheight-1,0);

if argument0[1] = 0 {
    // value
    var amount = (argument0[2]-argument0[3]) / (argument0[4]-argument0[3]) * 100;    

    draw_healthbar(argument1+nwidth, argument2+margin, argument1+nwidth+vwidth-w-margin, argument2+nheight-margin, amount, $2c2c2c, argument0[7], argument0[7], 0, true, false);
    draw_text(argument1+nwidth+vwidth-w+margin, argument2 + (nheight/2), argument0[2]);
}

if argument0[1] = 4 {
    draw_text(argument1+nwidth, argument2 + (nheight/2), argument0[2]);
}

// name
text = argument0[0 + 2 * (argument0[1] = 5)];

draw_set_color($eeeeee);
draw_text(round(10+argument1 + (argument0[1] == 2) * 8 + (argument0[1] == 3 || argument0[1] == 5)*((nwidth+vwidth) / 2 - string_width(text)/2 - margin*2)), round(argument2 + (nheight/2)), text);