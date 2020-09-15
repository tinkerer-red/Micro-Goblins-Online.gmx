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
sets[1] = 42;                       // numeric field width (slider)
sets[2] = "Open Controls"           // name of the button to open gui
sets[3] = "Close Controls";         // name of the button to close gui

// Itens are set with these values when created
sets[4] = 95;                       // name column width
sets[5] = 24;                       // name/value column height
sets[6] = 148;                      // value column width
sets[7] = 6;                        // margin
sets[8] = 20;                       // open/close button height

ds_list_add(g,sets);

return g;