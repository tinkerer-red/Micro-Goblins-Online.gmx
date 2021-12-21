///_draw_lore(item, x, y, w, h, scale)

var item = argument0;
var xx = argument1;
var yy = argument2;
var ww = argument3;
var hh = argument4;
var scale = argument5;

var height = sprite_get_height(fnt_menu)*scale;

//pull the description from the item
var desc = item[? "description"];

//clip words off untill the string fits into a single line
var list = string_split(desc, " ")
var line_array;
var j = 0

while (ds_list_size(list) != 0){
  
  var cut_desc = ""
  var next_word = " "+list[| 0]
  var i = 0
  
  while (string_width(cut_desc+next_word)*scale < ww){
    //keep adding words to the line
    cut_desc += next_word
    i++
    if (i = ds_list_size(list)) break;
    next_word = " "+list[| i]
  }
  
  //remove the cut_desc from the desc
  repeat (i) ds_list_delete(list, 0);
  
  //add the cut to the line array
  line_array[j] = cut_desc
  //the first two lines of the lore box are dedicated to the description alone
  draw_text_transformed(xx, yy+height*j, line_array[j], scale, scale, 0)
  j++
}



//make sure to destroy the previous list
ds_list_destroy(list)




//seporate the modifier strings
var mod_string = item[? "modifiers_string"]
var list = string_split(mod_string, ',')

//find the middle point of the lore box
var mid = ww/2

//the last three lines are for the modifier's names
for (var i = 0; i < ds_list_size(list); i++){
  var do_mid = i mod 2;
  var do_height = (i div 2)+2;
  
  //find the modifier's color value
  //
  
  //set color then draw
  draw_set_color(c_white)
  draw_text_transformed(xx+(do_mid*mid), yy+height*do_height, list[| i], scale, scale, 0);
  draw_set_color(c_white)
}



ds_list_destroy(list)

