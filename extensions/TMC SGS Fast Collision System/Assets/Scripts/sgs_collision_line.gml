/// sgs_collision_line(sgs_field, x1, y1, x2, y2, obj, prec, notme );
/*
read GML documentation for collision_line

Checks whether any instances of a given object collide with a given line, and if there is it returns the id of one of those instances.

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
var celx1 = median(0,floor((min(argument1,argument3))/cel_size),celxlst);
var cely1 = median(0,floor((min(argument2,argument4))/cel_size),celylst);
var celx2 = median(0,floor((max(argument1,argument3))/cel_size),celxlst);
var cely2 = median(0,floor((max(argument2,argument4))/cel_size),celylst);
var celxarr,celyarr,d,ct,arrat;
ct = 0;
arrat = 0;

for(celx = celx1; celx<=celx2; celx++)
{
    for(cely = cely1; cely<=cely2; cely++)
    {
        if(1==sgs_LineTouchesRect(argument1,argument2,argument3,argument4,celx*cel_size,cely*cel_size,(celx+1)*cel_size,(cely+1)*cel_size))
        {
            
            
            //with(instance_create(celx*cel_size,cely*cel_size,sgs_demo_debug_square))
            //{
            //    x = x+cel_size;
            //    y = y+cel_size;
            //    txt = "Line DB"//string(list_size)
            //}
            
            celxarr[arrat] = celx;
            celyarr[arrat] = cely;
            arrat++;
        }
    }
}
/*
//map x,y to 1 cell
var celxarr,celyarr,d,ct,arrat;
ct = 0;
arrat = 0;
d = max(abs(argument2-argument0),abs(argument3-argument4),1);
while(ct<d)
{
    celx = median(0,floor((argument1+(argument3-argument1)*(ct/d))/cel_size),celxlst);
    cely = median(0,floor((argument2+(argument4-argument2)*(ct/d))/cel_size),celylst);
     
    
    if(arrat>0)
    {
        if(!(celxarr[arrat-1] == celx and celyarr[arrat-1] == cely))
        {
            celxarr[arrat] = celx;
            celyarr[arrat] = cely;
            arrat++;
        }
    }
    else
    {
        celxarr[arrat] = celx;
        celyarr[arrat] = cely;
        arrat++;
    }
    ct+=1;

}
*/
ct = arrat;
//arrat=0;
var doit = false;
//while(arrat<ct)
for(arrat =0; arrat<ct; arrat++)
{
    //get the cell list
    celx = celxarr[arrat];
    cely = celyarr[arrat];
    //cel_list = ds_grid_get(grid,celx,cely);
    cel_list = grid[#celx,cely];
    list_size = ds_list_size(cel_list);
   
    
    //loop through items
    //list_at = 0;
    //while(list_at<list_size)
    for(list_at = 0; list_at<list_size; list_at++)
    {
        //iid = ds_list_find_value(cel_list,list_at)
        iid = cel_list[|list_at]
        {
            doit = false;
            if(iid.object_index == argument5) doit = true;
            else if(iid == argument5) doit = true;
            else if(object_is_ancestor(iid.object_index,argument5)) doit = true;
            else if(argument5 == all) doit = true;
            if(doit)
            {
                if(collision_line(argument1,argument2,argument3,argument4,iid,argument6,argument7))
                {
                    return iid;
                }
            }
        }   
        //list_at++;    
    }
    //arrat++;
}
return noone;
