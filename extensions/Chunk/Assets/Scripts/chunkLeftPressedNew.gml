screenToGridRelative(mouse_x,mouse_y); //we get the return values in temp values

var grid_x=global.temp[0];
var grid_y=global.temp[1];

gridRelativeToScreenAbsolute(grid_x,grid_y,id);

var paint_x=global.temp[3];
var paint_y=global.temp[4];


var everyone_value=analyseNeighbourTunnelsMoore(mouse_x,mouse_y);

//you
var cur_val=everyone_value >> 8;

//your friends
var neighbour_value=everyone_value-cur_val*256;

//and your Johnson®

if (cur_val==1)
    {    
    gridValueSetRelative(grid_x,grid_y,id,0);
    
    //so now they know there's nothing there
    //you just disappeared.
    //if there's nothing around, it's simple-
    //just erase everything underneath you.
    
    if (neighbour_value==0) //that means nothing around you. smart, huh.
        {
        //just erase everything underneath you.
        paintSpriteOntoScreenAbsolute(spr1pix,0,paint_x,paint_y,global.cell_size,global.cell_size,0,c_black,1,id);
        }
    else
        {
        //wait, why !cur val? because we've just changed it.
        var big_brush=composeMooreSurface(0,neighbour_value,paint_x,paint_y);
        paintSurfaceOntoScreenAbsolute(big_brush,paint_x-global.cell_size,paint_y-global.cell_size,id);
        surface_free(big_brush);
        }
    

    }
else
    {
    gridValueSetRelative(grid_x,grid_y,id,1);
    //and do the same. if it's just you there, paint the sprite.
    
    if (neighbour_value==0)
        {
        paintSpriteOntoScreenAbsolute(sprTunnelsMooreCore16,0,paint_x,paint_y,1,1,0,c_white,1,id);
        }
    else
        {
        var big_brush=composeMooreSurface(1,neighbour_value,paint_x,paint_y);
        paintSurfaceOntoScreenAbsolute(big_brush,paint_x-global.cell_size,paint_y-global.cell_size,id);
        surface_free(big_brush);
        }
    }
 
empty=false; //because we changed it now, that chunk is gonna get saved at some point

//show_message("Element will be painted at "+string(paint_x)+","+string(paint_y));

