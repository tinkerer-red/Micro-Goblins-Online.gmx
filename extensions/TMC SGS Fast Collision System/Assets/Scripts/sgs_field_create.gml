/// sgs_field_create(object_index,cell_size)
/**
 
    syntax:
        sgs_create(object_index,cell_size);
 
    param:
        object_index as object_index
            the object type to add to the field. can be a parent object.
 
    param: 
        cell_size as integer
            the size of the cells in the grid in pixels. the minimum size should be twice your largest object * it's maximum speed * the frameskip (see code).

    returns: field as integer
 
    desc:
        This function creates a SGS field for the specified object.
        Call this on room start in your controller object.
        
        A sgs_filed is a ds_list with items set to the field properties.
        This information about the list entries if for reference only.
        item 0 is the object_type use to fill the list.
        item 1 is the cell_size.
        item 2 is the ds_grid that holds all the ds_lists for each cell.
        item 3 is the change list which hold every list that was updated (duplicates entries may exists).
        item 4 is the next update time in microsecond.
        item 5 is the run limit for unlicensed use (deprecated).
 
    related:
        - sgs_field_destroy();
        - sgs_step();
 
    sources:
        author: icuurd12b42.
        company: The Mojo Collective.

    example:
        //Room Start Event
        //moving items
        global.ships_field = sgs_create(ships_par_obj,128);
        //static items
        global.walls_field = sgs_create(walls_par_obj,128);
        //static only needs filling once
        sgs_step(global.walls_field,0);
        
        //Step Event
        var frameskip = 10; //skip 10 frames/refresh content every 10 steps (approximately)
        sgs_step(global.ships_field,(1000000/room_speed) * frameskip);
*/

//Main container
var sgs_field = ds_list_create(); 
//the first item in the list is the object type (pos 0)
ds_list_add(sgs_field,argument0);
//the second item in the list is the cell size
ds_list_add(sgs_field,argument1);
//The grid holding the cells, create the size of the room
var grid = ds_grid_create(floor(room_width/argument1) +1,floor(room_width/argument1) +1)
//setup the grid with lists
var celx,cely,ww,hh;
ww = ds_grid_width(grid);
hh = ds_grid_height(grid);
for(celx = 0; celx<ww; celx++)
{
    for(cely = 0; cely<hh; cely++)
    {
        ds_grid_set(grid,celx,cely,ds_list_create());
    }
}
/*
var delta_grid = ds_grid_create(ww,hh)
for(celx = 0; celx<ww; celx++)
{
    for(cely = 0; cely<hh; cely++)
    {
        ds_grid_set(delta_grid,celx,cely,false);
    }
}
*/
//set as 3rd in the list (pos 2)
ds_list_add(sgs_field,grid);
//The list holding the cells containing information (pos 3)
ds_list_add(sgs_field,ds_list_create());
//next update time
ds_list_add(sgs_field,0)
//ds_list_add(sgs_field,delta_grid)
//return the list

//0 is object
//1 is the size
//2 is the grid of list of items found
//3 is the reference list of lists of changes
//4 is the next update time
//5 is the list added check (gone)
/*
if(!file_exists("sgs_licence.lic"))
{
    show_debug_message ("sgs gex: sgs_licence.lic not found. include the sgs licence file in your project's Included Files. To get a licence file Contact sgs publisher: gpage256@yahoo.ca");
    show_message ("sgs gex: sgs_licence.lic not found. include the sgs licence file in your project's Included Files. To get a licence file Contact sgs publisher: gpage256@yahoo.ca");;
    //next update time
    ds_list_add(sgs_field, get_timer()+ 1000000*60*1)
    file_text_close(hf);
    return sgs_field;
}
var hf = file_text_open_read("sgs_licence.lic")

var lic_no = file_text_read_string(hf)
if(lic_no!="9f428e21-6469-42b3-bd58-6b7e21b6cbae") 
{
    show_debug_message ("sgs gex: invalid licence registration number. Contact sgs publisher: gpage256@yahoo.ca");
    show_message ("sgs gex: invalid licence registration number. Contact sgs publisher: gpage256@yahoo.ca");
    ds_list_add(sgs_field, get_timer()+ 1000000*60*1)
    file_text_close(hf);
    return sgs_field;
}
file_text_close(hf);
ds_list_add(sgs_field, get_timer()+ 1000000*60*60*24*30)
*/
return sgs_field;
