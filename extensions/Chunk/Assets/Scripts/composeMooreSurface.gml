///composeMooreSurface(current_value,neighbours_value,paint_x,paint_y)
var surfey=surface_create(3*global.cell_size,3*global.cell_size);
surface_set_target(surfey);
draw_clear_alpha(c_black,0);

//talking to the middle tile (the one originally called):
//iterate throughout your neighbours

var neigh_xplus,neigh_yplus;

//some helpful vectors we can iterate through

//right
neigh_xplus[0]=global.cell_size;
neigh_yplus[0]=0;

//right-top
neigh_xplus[1]=global.cell_size;
neigh_yplus[1]=-global.cell_size;

//top
neigh_xplus[2]=0;
neigh_yplus[2]=-global.cell_size;

//top-left
neigh_xplus[3]=-global.cell_size;
neigh_yplus[3]=-global.cell_size;

//left
neigh_xplus[4]=-global.cell_size;
neigh_yplus[4]=0;

//left-bottom
neigh_xplus[5]=-global.cell_size;
neigh_yplus[5]=global.cell_size;

//bottom
neigh_xplus[6]=0;
neigh_yplus[6]=global.cell_size;

//bottom-right
neigh_xplus[7]=global.cell_size;
neigh_yplus[7]=global.cell_size;


for (var bit=0; bit<8; bit++)
{
var cur_neighbour=((argument[1] >> bit) & 1)==1;

if (cur_neighbour==1)
    {
    //make that neighbour check its neighbours,
    //and paint the neighbour according to THAT neighbour_value.
    //Middle cell (the one originally invoked) will be included in every neighbours list.
    //so it's important that this function, overall, gets called AFTER setting the value.
    var everyone_value2=analyseNeighbourTunnelsMoore(argument[2]+neigh_xplus[bit],argument[3]+neigh_yplus[bit]);
    //you
    var cur_val2=everyone_value2 >> 8;

    //your friends
    var neighbour_value2=everyone_value2-cur_val2*256; //yeah but we know it's always gonna subtract 256
    
    //and your Johnson
    
    
        //erase whatever underneath you
        draw_sprite_ext(spr1pix,0,argument[2]+neigh_xplus[bit],argument[3]+neigh_yplus[bit],global.cell_size,global.cell_size,0,c_black,1);
        //and paint yourself
        draw_sprite_ext(sprTunnelsMooreCore16,neighbour_value2,argument[2]+neigh_xplus[bit],argument[3]+neigh_yplus[bit],1,1,0,c_white,1);    

    }
}

//now, the original tile:
//are you drawing, or erasing yourself?

if (argument[0]==0)    //that mean's the value used to be 1 (since we're feeding it !cur_val, remember!) now it should be 0. erase.
    {
    draw_sprite_ext(spr1pix,0,global.cell_size,global.cell_size,global.cell_size,global.cell_size,0,c_black,1);
    }
else   //draw yourself nicely according to your neighbourhood value
    {
    draw_sprite_ext(sprTunnelsMooreCore16,argument[1],global.cell_size,global.cell_size,1,1,0,c_white,1);
    }
surface_reset_target();
return surfey;
