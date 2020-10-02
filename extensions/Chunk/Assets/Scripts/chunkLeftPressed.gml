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


var paint_colour=c_white; //for now!

var everyone_value=analyseNeighbourTunnelsVonNeumann(mouse_x,mouse_y);

//you
var cur_val=everyone_value >> 4;

//your friends
var neighbour_value=everyone_value-cur_val*16;

//and your Johnson®

if (cur_val==1)
    {
    //this is the tough case. we're erasing,
    //meaning we not only have to draw the anti-colour there,
    //we have to tell every neighbour that's also 1 (you can get this easily from the neighbour_value)
    //to also paint a proper (for it, of course) brush
    //in order to refresh the canvas.
    //we have to do this, otherwise some nasy holes are gonna remain till you re-paint
    //a particular gfx background.
    //eh.
    //for that, first, we're gonna paint everything on the surface,
    //and then paint that surface onto backgrounds.
    //thing is, if we didn't do this,
    //trying to draw something in cell x and cell y 0,0 (topleft corner)
    //would cause 4 x 4 more drawing than a single sprite on a single canvas.
    
    //the surface only needs to be as big as tunnel width (or height) times 3.
    //because at most, we're gonna paint over 3x3 cells.
    //so go on.
    //do it.
    //jesus.
    //stop writing this to avoid doing the surface.
    //I'm fucking serious now
    //okay
    //rrrrriiiiiiiiiiiiight
    //NOW!
    //...
    //you're still writing this aren't you
    //just get it over with
    //and then reward yourself with smoking
    
    //might as well change the value now, so the neighbours paint the correct sprite
    gridValueSetRelative(grid_x,grid_y,id,!cur_val);
    
    //so now they know there's nothing there
    
    paint_colour=c_black;
    make_emptiness_check=true;
    
    var bigbrush=surface_create(3*global.cell_size,3*global.cell_size);
    
    surface_set_target(bigbrush);
    //draw_background(bgBlankCanvas,0,0);
    draw_clear_alpha(c_black,0); 
    

    //first, paint the neighbours in white,
    //then, at the end, yourself in black
    
    //decide which neighbours.
    
    //is there something to your left?
    //(you're still the original cell clicked on).
    
    var neighbour_everyone_value=-1;
    var neighbour_cur_val=-1; //it's called just "val" to visually differentiate it
    var neighbour_neighbour_value=-1;
    
    //RIGHT
    if (neighbour_value & 1==1)
        {
        //show_message("1!");
        
        //do another neighbourhood check, this time for the neighbour's position.
        //you are now 0. so don't worry.
        neighbour_everyone_value=analyseNeighbourTunnelsVonNeumann(paint_x+global.cell_size,paint_y);
        neighbour_cur_val=neighbour_everyone_value >> 4;
        neighbour_neighbour_value=neighbour_everyone_value-neighbour_cur_val*16;        
       //show_message("this is the one that has just dissappeared: there's something to my right!");
       //clear whatever's underneath you with pitch black, but only 24x24!
        draw_sprite_ext(spr1pix,0,global.cell_size*2,global.cell_size,global.cell_size,global.cell_size,0,c_black,1);        
       
        //draw it, finally
        draw_sprite_ext(sprTunnelBrushAdditiveSharp,neighbour_neighbour_value,global.cell_size*2,global.cell_size,1,1,0,c_white,1);
        
        //yeah but also check for corners. jesus. so many checks.
        
        
        }
    //TOP
    if ((neighbour_value >> 1) & 1==1)
        {
        neighbour_everyone_value=analyseNeighbourTunnelsVonNeumann(paint_x,paint_y-global.cell_size);
        neighbour_cur_val=neighbour_everyone_value >> 4;
        neighbour_neighbour_value=neighbour_everyone_value-neighbour_cur_val*16;        
        draw_sprite_ext(spr1pix,0,global.cell_size,0,global.cell_size,global.cell_size,0,c_black,1);            
        draw_sprite_ext(sprTunnelBrushAdditiveSharp,neighbour_neighbour_value,global.cell_size,0,1,1,0,c_white,1);        
        }
    //LEFT
    if ((neighbour_value >> 2) & 1==1)
        {
        neighbour_everyone_value=analyseNeighbourTunnelsVonNeumann(paint_x-global.cell_size,paint_y);
        neighbour_cur_val=neighbour_everyone_value >> 4;
        neighbour_neighbour_value=neighbour_everyone_value-neighbour_cur_val*16;        
        draw_sprite_ext(spr1pix,0,0,global.cell_size,global.cell_size,global.cell_size,0,c_black,1);            
        draw_sprite_ext(sprTunnelBrushAdditiveSharp,neighbour_neighbour_value,0,global.cell_size,1,1,0,c_white,1);        
        }
    //DOWN    
    if ((neighbour_value >> 3) & 1==1)
        {
        neighbour_everyone_value=analyseNeighbourTunnelsVonNeumann(paint_x,paint_y+global.cell_size);
        neighbour_cur_val=neighbour_everyone_value >> 4;
        neighbour_neighbour_value=neighbour_everyone_value-neighbour_cur_val*16;        
        draw_sprite_ext(spr1pix,0,global.cell_size,global.cell_size*2,global.cell_size,global.cell_size,0,c_black,1);            
        draw_sprite_ext(sprTunnelBrushAdditiveSharp,neighbour_neighbour_value,global.cell_size,global.cell_size*2,1,1,0,c_white,1);      
        }
    
        
    //erase yourself now
    //since we're doing corners,
    ///erase the whole thing around you
    draw_sprite_ext(spr1pix,0,global.cell_size-4,global.cell_size-4,global.cell_size+8,global.cell_size+8,0,c_black,1);
    
    //done. was it so difficult afterall? You have some serious thinking to do
    //about your discipline, grasshopper. Yes, I'm my own mentor, apparently
    //go on, have a smoke now
    
    //debug
    /*
    draw_set_colour(c_blue);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_set_font(fntMicro);
    draw_text(48,48,"test");
    draw_set_colour(c_white);
    */
    
    surface_reset_target();
    
    paintSurfaceOntoScreenAbsolute(bigbrush,paint_x-global.cell_size,paint_y-global.cell_size,id);
    
    surface_free(bigbrush);
    
    //also, check if there's any ant colliders there (meaning, the ant is gonna step there next)
    //if there are, tell the collider owners that their next_x and next_y are now their x and y.
    //then, give those values to the collider.
    
    var collider_list=collision_point_list(paint_x,paint_y,objAntCollider,0,1);
    if (collider_list!=noone)
        {
        //we have some colliders there. fine. do it.
        
        for (var cl=0; cl<ds_list_size(collider_list); cl++)
            {
            var collie=collider_list[| cl];
            
            collie.owner.next_x=collie.owner.x;
            collie.owner.next_y=collie.owner.y;
            
            collie.x=collie.owner.x;
            collie.y=collie.owner.y;
            }
        
        ds_list_destroy(collider_list);
        }
    }
else
    {
    gridValueSetRelative(grid_x,grid_y,id,!cur_val);
    
    //but wait. check your whole neighbourhood now (moore)
    //and if it turns out you have 3 neighbours on
    //either "corner" (you know what I mean), you should
    //draw a tiny 2x2 square there.
    //Since you can draw multiple of those,
    //use a surface too.
    
    var everyone_value2=analyseNeighbourTunnelsMoore(mouse_x,mouse_y);

    //you
    var cur_val2=1;//everyone_value >> 5; //yeah but really it's 1. We know that. We just set it to 1

    //your kids
    var neighbour_value2=everyone_value2-256; //yeah cause we know for sure the first value is 1.

    //and your Johnson®
    var neigh;
    
    neigh[0]=(neighbour_value2 & 1)==1;         //RIGHT
    neigh[1]=((neighbour_value2 >> 1) & 1)==1;  //RIGHT-TOP
    neigh[2]=((neighbour_value2 >> 2) & 1)==1;  //TOP
    neigh[3]=((neighbour_value2 >> 3) & 1)==1;  //TOP-LEFT
    neigh[4]=((neighbour_value2 >> 4) & 1)==1;  //LEFT
    neigh[5]=((neighbour_value2 >> 5) & 1)==1;  //LEFT-BOTTOM
    neigh[6]=((neighbour_value2 >> 6) & 1)==1;  //BOTTOM
    neigh[7]=((neighbour_value2 >> 7) & 1)==1;  //BOTTOM-RIGHT
    
    var just_paint_the_sprite=true;
    
    var corner_to_paint;
    
    corner_to_paint[0]=false;
    corner_to_paint[1]=false;
    corner_to_paint[2]=false;
    corner_to_paint[3]=false;
        
    if (neigh[0] and neigh[1] and neigh[2])
        {
        corner_to_paint[0]=true;
        just_paint_the_sprite=false;
        }
        
    if (neigh[2] and neigh[3] and neigh[4])
        {
        corner_to_paint[1]=1;
        just_paint_the_sprite=false;
        }        
        
    if (neigh[4] and neigh[5] and neigh[6])
        {
        corner_to_paint[2]=1;
        just_paint_the_sprite=false;
        }        
        
    if (neigh[6] and neigh[7] and neigh[0])
        {
        corner_to_paint[3]=1;
        just_paint_the_sprite=false;
        }
    
    if (just_paint_the_sprite==true)
        {
        paintSpriteOntoScreenAbsolute(sprTunnelBrushAdditiveSharp,neighbour_value,paint_x,paint_y,1,1,0,c_white,1,id);
        }
    else
        {
        //welp, we're doing the surface.
        //show_message("PUT A CORNER!");
        var sizey=42;
        var corner_surface=surface_create(sizey,sizey);
        surface_set_target(corner_surface);
        draw_clear_alpha(c_black,0);
        
        //first, yourself
        
        draw_sprite_ext(sprTunnelBrushAdditiveSharp,neighbour_value,9,9,1,1,0,c_white,1);
        
        if (corner_to_paint[0])
            draw_sprite_ext(spr1pix,0,29,5,8,8,0,c_white,1);
        
        if (corner_to_paint[1])
            draw_sprite_ext(spr1pix,0,5,5,8,8,0,c_white,1);
        
        if (corner_to_paint[2])
            draw_sprite_ext(spr1pix,0,5,29,8,8,0,c_white,1);
        
        if (corner_to_paint[3])
            draw_sprite_ext(spr1pix,0,29,29,8,8,0,c_white,1);
        
        surface_reset_target();
        
        paintSurfaceOntoScreenAbsolute(corner_surface,paint_x-9,paint_y-9,id);
        
        surface_free(corner_surface);       
        }
    }
    
    




empty=false; //because we changed it now

//show_message("Element will be painted at "+string(paint_x)+","+string(paint_y));
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


var paint_colour=c_white; //for now!

var everyone_value=analyseNeighbourTunnelsVonNeumann(mouse_x,mouse_y);

//you
var cur_val=everyone_value >> 4;

//your friends
var neighbour_value=everyone_value-cur_val*16;

//and your Johnson®

if (cur_val==1)
    {
    //this is the tough case. we're erasing,
    //meaning we not only have to draw the anti-colour there,
    //we have to tell every neighbour that's also 1 (you can get this easily from the neighbour_value)
    //to also paint a proper (for it, of course) brush
    //in order to refresh the canvas.
    //we have to do this, otherwise some nasy holes are gonna remain till you re-paint
    //a particular gfx background.
    //eh.
    //for that, first, we're gonna paint everything on the surface,
    //and then paint that surface onto backgrounds.
    //thing is, if we didn't do this,
    //trying to draw something in cell x and cell y 0,0 (topleft corner)
    //would cause 4 x 4 more drawing than a single sprite on a single canvas.
    
    //the surface only needs to be as big as tunnel width (or height) times 3.
    //because at most, we're gonna paint over 3x3 cells.
    //so go on.
    //do it.
    //jesus.
    //stop writing this to avoid doing the surface.
    //I'm fucking serious now
    //okay
    //rrrrriiiiiiiiiiiiight
    //NOW!
    //...
    //you're still writing this aren't you
    //just get it over with
    //and then reward yourself with smoking
    
    //might as well change the value now, so the neighbours paint the correct sprite
    gridValueSetRelative(grid_x,grid_y,id,!cur_val);
    
    //so now they know there's nothing there
    
    paint_colour=c_black;
    make_emptiness_check=true;
    
    var bigbrush=surface_create(3*global.cell_size,3*global.cell_size);
    
    surface_set_target(bigbrush);
    //draw_background(bgBlankCanvas,0,0);
    draw_clear_alpha(c_black,0); 
    

    //first, paint the neighbours in white,
    //then, at the end, yourself in black
    
    //decide which neighbours.
    
    //is there something to your left?
    //(you're still the original cell clicked on).
    
    var neighbour_everyone_value=-1;
    var neighbour_cur_val=-1; //it's called just "val" to visually differentiate it
    var neighbour_neighbour_value=-1;
    
    //RIGHT
    if (neighbour_value & 1==1)
        {
        //show_message("1!");
        
        //do another neighbourhood check, this time for the neighbour's position.
        //you are now 0. so don't worry.
        neighbour_everyone_value=analyseNeighbourTunnelsVonNeumann(paint_x+global.cell_size,paint_y);
        neighbour_cur_val=neighbour_everyone_value >> 4;
        neighbour_neighbour_value=neighbour_everyone_value-neighbour_cur_val*16;        
       //show_message("this is the one that has just dissappeared: there's something to my right!");
       //clear whatever's underneath you with pitch black, but only 24x24!
        draw_sprite_ext(spr1pix,0,global.cell_size*2,global.cell_size,global.cell_size,global.cell_size,0,c_black,1);        
       
        //draw it, finally
        draw_sprite_ext(sprTunnelBrushAdditiveSharp,neighbour_neighbour_value,global.cell_size*2,global.cell_size,1,1,0,c_white,1);
        
        //yeah but also check for corners. jesus. so many checks.
        
        
        }
    //TOP
    if ((neighbour_value >> 1) & 1==1)
        {
        neighbour_everyone_value=analyseNeighbourTunnelsVonNeumann(paint_x,paint_y-global.cell_size);
        neighbour_cur_val=neighbour_everyone_value >> 4;
        neighbour_neighbour_value=neighbour_everyone_value-neighbour_cur_val*16;        
        draw_sprite_ext(spr1pix,0,global.cell_size,0,global.cell_size,global.cell_size,0,c_black,1);            
        draw_sprite_ext(sprTunnelBrushAdditiveSharp,neighbour_neighbour_value,global.cell_size,0,1,1,0,c_white,1);        
        }
    //LEFT
    if ((neighbour_value >> 2) & 1==1)
        {
        neighbour_everyone_value=analyseNeighbourTunnelsVonNeumann(paint_x-global.cell_size,paint_y);
        neighbour_cur_val=neighbour_everyone_value >> 4;
        neighbour_neighbour_value=neighbour_everyone_value-neighbour_cur_val*16;        
        draw_sprite_ext(spr1pix,0,0,global.cell_size,global.cell_size,global.cell_size,0,c_black,1);            
        draw_sprite_ext(sprTunnelBrushAdditiveSharp,neighbour_neighbour_value,0,global.cell_size,1,1,0,c_white,1);        
        }
    //DOWN    
    if ((neighbour_value >> 3) & 1==1)
        {
        neighbour_everyone_value=analyseNeighbourTunnelsVonNeumann(paint_x,paint_y+global.cell_size);
        neighbour_cur_val=neighbour_everyone_value >> 4;
        neighbour_neighbour_value=neighbour_everyone_value-neighbour_cur_val*16;        
        draw_sprite_ext(spr1pix,0,global.cell_size,global.cell_size*2,global.cell_size,global.cell_size,0,c_black,1);            
        draw_sprite_ext(sprTunnelBrushAdditiveSharp,neighbour_neighbour_value,global.cell_size,global.cell_size*2,1,1,0,c_white,1);      
        }
    
        
    //erase yourself now
    //since we're doing corners,
    ///erase the whole thing around you
    draw_sprite_ext(spr1pix,0,global.cell_size-4,global.cell_size-4,global.cell_size+8,global.cell_size+8,0,c_black,1);
    
    //done. was it so difficult afterall? You have some serious thinking to do
    //about your discipline, grasshopper. Yes, I'm my own mentor, apparently
    //go on, have a smoke now
    
    //debug
    /*
    draw_set_colour(c_blue);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_set_font(fntMicro);
    draw_text(48,48,"test");
    draw_set_colour(c_white);
    */
    
    surface_reset_target();
    
    paintSurfaceOntoScreenAbsolute(bigbrush,paint_x-global.cell_size,paint_y-global.cell_size,id);
    
    surface_free(bigbrush);
    
    //also, check if there's any ant colliders there (meaning, the ant is gonna step there next)
    //if there are, tell the collider owners that their next_x and next_y are now their x and y.
    //then, give those values to the collider.
    
    var collider_list=collision_point_list(paint_x,paint_y,objAntCollider,0,1);
    if (collider_list!=noone)
        {
        //we have some colliders there. fine. do it.
        
        for (var cl=0; cl<ds_list_size(collider_list); cl++)
            {
            var collie=collider_list[| cl];
            
            collie.owner.next_x=collie.owner.x;
            collie.owner.next_y=collie.owner.y;
            
            collie.x=collie.owner.x;
            collie.y=collie.owner.y;
            }
        
        ds_list_destroy(collider_list);
        }
    }
else
    {
    gridValueSetRelative(grid_x,grid_y,id,!cur_val);
    
    //but wait. check your whole neighbourhood now (moore)
    //and if it turns out you have 3 neighbours on
    //either "corner" (you know what I mean), you should
    //draw a tiny 2x2 square there.
    //Since you can draw multiple of those,
    //use a surface too.
    
    var everyone_value2=analyseNeighbourTunnelsMoore(mouse_x,mouse_y);

    //you
    var cur_val2=1;//everyone_value >> 5; //yeah but really it's 1. We know that. We just set it to 1

    //your kids
    var neighbour_value2=everyone_value2-256; //yeah cause we know for sure the first value is 1.

    //and your Johnson®
    var neigh;
    
    neigh[0]=(neighbour_value2 & 1)==1;         //RIGHT
    neigh[1]=((neighbour_value2 >> 1) & 1)==1;  //RIGHT-TOP
    neigh[2]=((neighbour_value2 >> 2) & 1)==1;  //TOP
    neigh[3]=((neighbour_value2 >> 3) & 1)==1;  //TOP-LEFT
    neigh[4]=((neighbour_value2 >> 4) & 1)==1;  //LEFT
    neigh[5]=((neighbour_value2 >> 5) & 1)==1;  //LEFT-BOTTOM
    neigh[6]=((neighbour_value2 >> 6) & 1)==1;  //BOTTOM
    neigh[7]=((neighbour_value2 >> 7) & 1)==1;  //BOTTOM-RIGHT
    
    var just_paint_the_sprite=true;
    
    var corner_to_paint;
    
    corner_to_paint[0]=false;
    corner_to_paint[1]=false;
    corner_to_paint[2]=false;
    corner_to_paint[3]=false;
        
    if (neigh[0] and neigh[1] and neigh[2])
        {
        corner_to_paint[0]=true;
        just_paint_the_sprite=false;
        }
        
    if (neigh[2] and neigh[3] and neigh[4])
        {
        corner_to_paint[1]=1;
        just_paint_the_sprite=false;
        }        
        
    if (neigh[4] and neigh[5] and neigh[6])
        {
        corner_to_paint[2]=1;
        just_paint_the_sprite=false;
        }        
        
    if (neigh[6] and neigh[7] and neigh[0])
        {
        corner_to_paint[3]=1;
        just_paint_the_sprite=false;
        }
    
    if (just_paint_the_sprite==true)
        {
        paintSpriteOntoScreenAbsolute(sprTunnelBrushAdditiveSharp,neighbour_value,paint_x,paint_y,1,1,0,c_white,1,id);
        }
    else
        {
        //welp, we're doing the surface.
        //show_message("PUT A CORNER!");
        var sizey=42;
        var corner_surface=surface_create(sizey,sizey);
        surface_set_target(corner_surface);
        draw_clear_alpha(c_black,0);
        
        //first, yourself
        
        draw_sprite_ext(sprTunnelBrushAdditiveSharp,neighbour_value,9,9,1,1,0,c_white,1);
        
        if (corner_to_paint[0])
            draw_sprite_ext(spr1pix,0,29,5,8,8,0,c_white,1);
        
        if (corner_to_paint[1])
            draw_sprite_ext(spr1pix,0,5,5,8,8,0,c_white,1);
        
        if (corner_to_paint[2])
            draw_sprite_ext(spr1pix,0,5,29,8,8,0,c_white,1);
        
        if (corner_to_paint[3])
            draw_sprite_ext(spr1pix,0,29,29,8,8,0,c_white,1);
        
        surface_reset_target();
        
        paintSurfaceOntoScreenAbsolute(corner_surface,paint_x-9,paint_y-9,id);
        
        surface_free(corner_surface);       
        }
    }
    
    




empty=false; //because we changed it now

//show_message("Element will be painted at "+string(paint_x)+","+string(paint_y));

