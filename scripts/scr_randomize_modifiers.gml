///scr_randomize_modifiers()


var mod_count = gui_get_value(guid, "Random Mod Count");



//reset all modifiers to 0
scr_guid_clear_modifiers()



//debug console; lets go ahead and clear those values too
var size = ds_list_size(guid)

for (var i = 0; i < size; i++){
  var gui_item = guid[| i]
  
  if (gui_item[0] = "Random")
  || (gui_item[0] = "Random Mod Count")
  || (gui_item[0] = "Randomize Mods"){
    break;
  }
  
  //if slider
  if (gui_item[1] = 0){
    //if size is 0-5
    if (gui_item[3] = 0) && (gui_item[4] = 5){
      gui_set_value(guid, gui_item[0], 0)
    }
  }
}



///prep for applying new mods
var mod_end = i-1
var finished_mods = 0

while (finished_mods < mod_count){
  
  var mod_id = irandom(mod_end);
  
  var gui_item = guid[| mod_id]
  
  //show_debug_message("gui_item[1] = "+string(gui_item[1]))
  //show_debug_message(gui_item)
  
  //if slider
  if (gui_item[1] = 0){
    
    //if size is 0-5
    if (gui_item[3] = 0) && (gui_item[4] = 5){
      show_debug_message("0-5")
      //gui_item[2] += 1
      gui_set_value(guid, gui_item[0], gui_item[2] + 1)
      finished_mods++
      show_debug_message("gui_item = "+string(gui_item))
    }
  }
}

update_debug = true;
