/// sgs_collision_point(sgs_field, x, y, obj, prec, notme);
/*
read GML documentation for collision_point

Checks a specific, user defined point for a collision with the an instance of the chosen object.

sgs_field is the field to use for segregated check
note, for speed sake the code assumes everything is good with the data structures

if you plan to destroy the instance, use the _s (Safe) variant


retuns the id or noone
*/

var sgs_field = argument0;

//get size
var cel_size = ds_list_find_value(sgs_field,1);
//get grid
var grid = ds_list_find_value(sgs_field,2);



var celx,cely,ww,hh,celxlst,celylst,cel_list,list_size,list_at,iid;
//size and min max pos
ww = ds_grid_width(grid);
hh = ds_grid_height(grid);
celxlst = ww-1;
celylst = hh-1;
//map x,y to 1 cell
celx = median(0,floor(argument1/cel_size),celxlst);
cely = median(0,floor(argument2/cel_size),celylst);
//get the cell list
cel_list = ds_grid_get(grid,celx,cely);
list_size = ds_list_size(cel_list);
//loop through items
var doit = false;
for(list_at = 0; list_at<list_size; list_at++)
{
    //iid = ds_list_find_value(cel_list,list_at)
    iid = cel_list[|list_at];
    {
        doit = false;
        //if collision check finds something with matching params
        if(iid.object_index == argument3) doit = true;
        else if(iid == argument3) doit = true;
        else if(object_is_ancestor(iid.object_index,argument3)) doit = true;
        else if(argument3 == all) doit = true;
        if(doit)
        {
            if(collision_point(argument1,argument2,iid,argument4,argument5))
            {
                return iid;
            }
        }   
    }
}
return noone;
