/// sgs_step(sgs_field)
/*
Call evey step in the object controlling the field
*/
var sgs_field = argument0;

//get the time
var tm = get_timer();

//get the next time
var nexttime = ds_list_find_value(sgs_field,4);

//skip if too soon
if(nexttime>tm) exit;
//next update time
ds_list_replace(sgs_field,4,tm+argument1);

//show_debug_message(string(tm));
//get the obj type
var obj_idx = ds_list_find_value(sgs_field,0);
//get the cell size
var cel_size = ds_list_find_value(sgs_field,1);
//get the grid
var grid = ds_list_find_value(sgs_field,2);
//Get The list holding the cells containing information
var change_list = ds_list_find_value(sgs_field,3);

//reference list check was a dud
//var delta_grid = ds_list_find_value(sgs_field,5);

var celx1,cely1,celx2,cely2,ww,hh,celxlst,celylst,curx,cury;
//get the dimentions
ww = ds_grid_width(grid);
hh = ds_grid_height(grid);
//about the clean the cell list that have changed
var change_count = ds_list_size(change_list);
var change_at, cel_list;
//method 1 if the number of cells is smaller than the change count
//loop though all the cells, get the list and clear it
if(change_count<ww*hh)
{
    for(change_at = 0; change_at<change_count; change_at++)
    {
        //cel_list = ds_list_find_value(change_list,change_at);
        cel_list = change_list[|change_at];
        ds_list_clear(cel_list);
    }
}
else //method 2 using the change list, get the list and clear it
{
    for (celx1 = 0; celx1<ww; celx1 ++)
    {
        for (cely1 = 0; cely1<hh; cely1 ++)
        {
            //cel_list = ds_grid_get(grid,celx1,cely1);
            cel_list = grid[#celx1,cely1];
            ds_list_clear(cel_list);
        }
    }
}
//clear the change list
ds_list_clear(change_list);

//reference list check was a dud
//ds_grid_clear(delta_grid,false);

//now loop through all instance of object type
celxlst = ww-1;
celylst = hh-1;
var lidx = 0;
with(obj_idx)
{
    //figure out the extent of the bounding box
    celx1 = median(0,floor(bbox_left/cel_size),celxlst);
    cely1 = median(0,floor(bbox_top/cel_size),celylst);
    celx2 = median(0,floor(bbox_right/cel_size),celxlst);
    cely2 = median(0,floor(bbox_bottom/cel_size),celylst);
    
    for(curx=celx1;curx<=celx2;curx++)
    {
        for(cury=cely1;cury<=cely2;cury++)
        {
            //cel_list = ds_grid_get(grid,curx,cury);
            cel_list = grid[#curx,cury];
            //reference list check was a dud
            //if(delta_grid[#curx,cury]==false)
            {
                //ds_list_add(change_list,cel_list);
                change_list[|lidx++] = cel_list;
                //reference list check was a dud
                //delta_grid[#curx,cury]=true;
            }
            ds_list_add(cel_list,id);
        }
    }
    /*
    //add first corner in cell at position
    cel_list = ds_grid_get(grid,celx1,cely1);
    ds_list_add(change_list,cel_list);
    ds_list_add(cel_list,id);
    //if right is in another cell
    if(celx1!=celx2)
    {
        //add in the other cell
        cel_list = ds_grid_get(grid,celx2,cely1);
        ds_list_add(change_list,cel_list);
        ds_list_add(cel_list,id);
    }
    //if botton is in another cell below
    if(cely1!=cely2)
    {
        //add to other cell below
        cel_list = ds_grid_get(grid,celx1,cely2);
        ds_list_add(change_list,cel_list);
        ds_list_add(cel_list,id);
        //and add the bottom right if in another cell too
        if(celx1!=celx2)
        {
            cel_list = ds_grid_get(grid,celx2,cely2);
            ds_list_add(change_list,cel_list);
            ds_list_add(cel_list,id);
        }
    }
    //that should cover 1, 2 or 4 cells overlap
    */
}
