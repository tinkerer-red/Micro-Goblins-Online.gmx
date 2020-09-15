/// gui_destroy_gui(gui);
/*
    Destroy gui
*/

n = ds_list_size(argument0);

// Free arrays
for (var i = 0; i < n; i++ ) {
    argument0[|i] = 0;
}

// Destroy gui
ds_list_destroy(argument0);