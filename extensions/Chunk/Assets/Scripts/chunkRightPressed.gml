//it's good practice not to re-use the same global.variables.
//it might lead to messy results otherwise.
//so these functions down here use diferent temp registires,
//just in case. I had trouble with them before...

screenToGridRelative(mouse_x,mouse_y); //we get the return values in temp values

var grid_x=global.temp[0];
var grid_y=global.temp[1];

//show_message("Clicked on "+string(global.temp[2])+", coords are "+string(grid_x)+","+string(grid_y));

gridRelativeToScreenAbsolute(grid_x,grid_y,id);

var paint_x=global.temp[3];
var paint_y=global.temp[4];


var cur_val=gridValueGetRelative(grid_x,grid_y,id);
//show_message(cur_val);
if (cur_val==1)
    {
    instance_create(paint_x,paint_y,objAnt);
    }
//because we changed it now

//show_message("Element will be painted at "+string(paint_x)+","+string(paint_y));

