/// sgs_field_destroy(sgs_field)
/*
destroys a sgs_field created with sgs_field_create()
*/
var sgs_field = argument0;
if(!ds_exists(sgs_field, ds_type_list)) exit;
//get the grid at pos 2
var grid = ds_list_find_value(sgs_field,2)
if(ds_exists(grid, ds_type_grid))
{
    //delete the lists in the grid
    var celx,cely,ww,hh,cel_list;
    ww = ds_grid_width(grid);
    hh = ds_grid_height(grid);
    
    for(celx = 0; celx<ww; celx++)
    {
        for(cely = 0; cely<hh; cely++)
        {
            cel_list = ds_grid_get(grid,celx,cely);
            if(ds_exists(cel_list, ds_type_list))
            {
                ds_list_destroy(cel_list);
            }
        }
    }
}

//The list holding the cells lists containing information
var change_list = ds_list_find_value(sgs_field,3);
if(ds_exists(change_list, ds_type_list)) 
{
    ds_list_destroy(change_list);
}
//var change_grid = ds_list_find_value(sgs_field,5);
//ds_grid_destroy(change_grid);

//destroy the main container
ds_list_destroy(sgs_field);
