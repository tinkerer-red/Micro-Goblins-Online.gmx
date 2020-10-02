/// sgs_instance_place(sgs_field, x, y, obj);
/*
read GML documentation for instance_place

Checks for a collision with the specified object and returns its id.

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
var celx1,cely1,celx2,cely2;
celx1 = median(0,floor((argument1-sprite_xoffset)/cel_size),celxlst);
cely1 = median(0,floor((argument2-sprite_yoffset)/cel_size),celylst);
celx2 = median(0,floor((argument1-sprite_xoffset+sprite_width)/cel_size),celxlst);
cely2 = median(0,floor((argument2-sprite_yoffset+sprite_height)/cel_size),celylst);

var doit = false;
//celx=celx1
//while(celx<=celx2)
for(celx=celx1;celx<=celx2;celx++)
{
    //cely=cely1
    //while(cely<=cely2)
    for(cely=cely1;cely<=cely2;cely++)
    {
        
        //get the cell list
        //cel_list = ds_grid_get(grid,celx,cely);
        cel_list = grid[#celx,cely];
        list_size = ds_list_size(cel_list);
        //with(instance_create(celx*cel_size,cely*cel_size,sgs_demo_debug_square))
        //{
        //   x = x+cel_size;
        //    y = y+cel_size;
        //    txt = string(list_size)
        //}
        
        //loop through items
        //list_at = 0;
        //while(list_at<list_size)
        for(list_at = 0;list_at<list_size;list_at++)
        {
            //if collision check finds something with matching params
            //iid = ds_list_find_value(cel_list,list_at)
            iid = cel_list[|list_at];
            {
                doit = false;
                if(iid.object_index == argument3) doit = true;
                else if(iid == argument3) doit = true;
                else if(object_is_ancestor(iid.object_index,argument3)) doit = true;
                else if(argument3 == all) doit = true;
                if(doit)
                {
                    if(id != iid && instance_place(argument1,argument2,iid))
                    {
                        return iid;
                    }
                }
            }     
            //list_at++;    
        }
        //cely++;    
    }
    
    //celx++;
}
return noone;
