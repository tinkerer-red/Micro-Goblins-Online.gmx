/// sgs_instance_nearest(sgs_field, x, y, obj, max_range);
/*
read GML documentation for instance_nearest

Returns the id of the instance of an object nearest to a given position.

sgs_field is the field to use for segregated check
note, for speed sake the code assumes everything is good with the data structures

note: max_range is a parameter that limits the size of the search. 
note: the instance doing the call is ommited, unlike instance_nearest
note, for speed sake the code assumes everything is good with the data structures

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
var celx1,cely1,celx2,cely2,celrad;
celrad = (argument4/cel_size)
celx1 = median(0,floor((argument1-argument4)/cel_size),celxlst);
cely1 = median(0,floor((argument2-argument4)/cel_size),celylst);
celx2 = median(0,floor((argument1+argument4)/cel_size),celxlst);
cely2 = median(0,floor((argument2+argument4)/cel_size),celylst);

var maxd = argument4+argument4+1;
var closest_id = noone;

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
        //    x = x+cel_size;
        //    y = y+cel_size;
        //    txt = string(list_size)
        //}
        
        //loop through items
        //list_at = 0;
        //while(list_at<list_size)
        for(list_at = 0;list_at<list_size;list_at++)
        {
            //iid = ds_list_find_value(cel_list,list_at)
            iid = cel_list[|list_at];
            {
                if(id !=iid and iid != closest_id) //the id may be found maultiple times, this may skip a few 
                {
                    
                    
                    if(instance_exists(iid))
                    {
                        ds = point_distance(argument1,argument2,iid.x,iid.y)
                        if(ds<maxd)
                        {
                            //if collision check finds something with matching params
                            if(iid.object_index == argument3 or object_is_ancestor(iid.object_index,argument3) or argument3 == all)
                            {
                                maxd = ds;
                                closest_id = iid;
                            }
                        }
                        
                    }
                    
                    
                }
                
            }   
            //list_at++;    
        }
        //cely++;    
    }
    
    //celx++;
}

return closest_id;
        
