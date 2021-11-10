/// gui_create_gui();
/*
    Create new gui (group of item)
    
    return gui id
*/

var g = ds_list_create();

var sets;
sets[9] = $d6a12f;                  // value color

// == Default Settings == //

sets[0] = 1;                        // opened/closed
sets[1] = 16;  // numeric field width (input for slider)
sets[2] = "Open Debug Controls"                     // name of the button to open gui
sets[3] = "Close Debug Controls";                   // name of the button to close gui
//248
// Itens are set with these values when created
sets[4] = 168; // name column width
sets[5] = 18;  // name/value column height
sets[6] = 70; // value column width    ///this value does absolutely nothing
sets[7] = 3;   // margin
sets[8] = 24;  // open/close button height

ds_list_add(g,sets);

return g;
