/// sgs_collision_event_emu_c(sgs_field, collision_script);
/*
The _c (cell) varient performs the check only in the current cell
without accounting for cell overlap for the calling instance
which may be prone to errors but is faster

calls the script provided for all collisions the instance is colliding with
returns the number of instances the instance is colliding with
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
var celx1,cely1,celx2,cely2,xx,yy;
xx =x;
yy =y;
celx1 = median(0,floor((xx)/cel_size),celxlst);
cely1 = median(0,floor((yy)/cel_size),celylst);
celx2 = median(0,floor((xx)/cel_size),celxlst);
cely2 = median(0,floor((yy)/cel_size),celylst);

var ct = 0;
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
        //if(object_index == sga_demo_collsion_test)
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
                if(id !=iid && place_meeting(xx,yy,iid))
                {
                    ct+=1;
                    if(script_execute(argument1,iid)) return ct;
                    
                }
            }       
            //list_at++;    
        }
        //cely++;    
    }
    
    //celx++;
}
return ct;

