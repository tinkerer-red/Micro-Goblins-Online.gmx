///paintSpriteOntoScreenAbsolute(sprite,subimage,x,y,xscale,yscale,rot,col,alpha,calling_chunk)
var _sprite=argument[0];
var _subimg=argument[1];
var _x=argument[2];
var _y=argument[3];
var _xscale=argument[4];
var _yscale=argument[5];
var _rot=argument[6];
var _colour=argument[7];
var _alpha=argument[8];
var chunkey=argument[9];

//now, there's a chance whatever you wanna draw
//is overlapping a few backgrounds.
//to take this into account,
//create an ephemeridal collider object
//that will take the position, sprite, subimage and whatever
//else you provided.
//Then, it will
//make all (active) chunks
//perform a check
//for the 4 neighbouring chunks (sprites are not gonna be 384 pixels big, so no point in going further)

//how do you know if to even bother checking?
//well my friend, let's see if the collider's BBOX
//overlaps (or goes over) one of the edges.

var collider=instance_create(_x,_y,objCrashDummy);

collider.sprite_index=_sprite;
collider.image_index=_subimg;
collider.x=_x;
collider.y=_y;
collider.image_xscale=_xscale;
collider.image_yscale=_yscale;
collider.image_angle=_rot;
//blend and alpha don't matter here

//now, which chunks to ask to join your art club?
//you might be painting on up to 4 neighbours at a time.
//there's 8 possible neighbours to ask. Go on.

var neighbour_list=ds_list_create();
var neigh;

//starting from right and going counter clockwise,
//like the rotation
//this might turned into getNeighbouringChunkList later.




neigh=chunkAtPos(x+global.chunk_length,y);
if (neigh!=noone)
    {
    with (collider)
        if (place_meeting(x,y,chunkey))
        ds_list_add(neighbour_list,neigh);
    }

neigh=chunkAtPos(x+global.chunk_length,y-global.chunk_length);
if (neigh!=noone)
    {
    with (collider)
        if (place_meeting(x,y,chunkey))
        ds_list_add(neighbour_list,neigh);
    }

    
neigh=chunkAtPos(x,y-global.chunk_length);
if (neigh!=noone)
    {
    with (collider)
        if (place_meeting(x,y,chunkey))
        ds_list_add(neighbour_list,neigh);
    }


neigh=chunkAtPos(x-global.chunk_length,y-global.chunk_length);
if (neigh!=noone)
    {
    with (collider)
        if (place_meeting(x,y,chunkey))
        ds_list_add(neighbour_list,neigh);
    }

    
neigh=chunkAtPos(x-global.chunk_length,y);
if (neigh!=noone)
    {
    with (collider)
        if (place_meeting(x,y,chunkey))
        ds_list_add(neighbour_list,neigh);
    }

    
neigh=chunkAtPos(x-global.chunk_length,y+global.chunk_length);
if (neigh!=noone)
    {
    with (collider)
        if (place_meeting(x,y,chunkey))
        ds_list_add(neighbour_list,neigh);
    }


neigh=chunkAtPos(x,y+global.chunk_length);
if (neigh!=noone)
    {
    with (collider)
        if (place_meeting(x,y,chunkey))
        ds_list_add(neighbour_list,neigh);
    }


neigh=chunkAtPos(x+global.chunk_length,y+global.chunk_length);
if (neigh!=noone)
    {
    with (collider)
        if (place_meeting(x,y,chunkey))
        ds_list_add(neighbour_list,neigh);
    }


//don't forget!
ds_list_add(neighbour_list,chunkey);
            
//now iterate through the list.
//including yourself.
//for every member, paint on it's background.
//at the moment, you don't have any sprites that would overlap -
//perhaps do a test anyway?


for (var i=0; i<ds_list_size(neighbour_list); i++)
    {
    var chunkerino=neighbour_list[| i];
    
    with (chunkerino)
    {
    
    //create a new, temporary surface
    var surferino=surface_create(global.chunk_length,global.chunk_length);
    draw_clear_alpha(c_black,0);
    
    //paint the current background on
    surface_set_target(surferino);
        {
        //THIS. YOU NEED TO DO THIS FOR SOME FUCKING REASON.
        //OTHERWISE IT'S GONNA DRAW WHATEVER ELSE WAS DRAWN PREVIOUSLY.
        //WHY, I HAVE NO IDEA.
        //but... the thing works, and that's important.
        //took you almost 2 hours to fucking fix.
        //still haven't figured out why weird stuff happens
        //when the background is not drawn...
        draw_background(bgBlankCanvas,0,0);
        draw_set_blend_mode(bm_add);
        draw_background(tunnel_gfx,0,0); //draw the current stuff you idiot.
        draw_set_blend_mode(bm_normal);
        draw_sprite_ext(_sprite,_subimg,_x-x,_y-y,_xscale,_yscale,_rot,_colour,_alpha);
        }
    surface_reset_target();

    background_delete(tunnel_gfx);

    tunnel_gfx=background_create_from_surface(surferino,0,0,global.chunk_length,global.chunk_length,0,0);
    background_set_alpha_from_background(tunnel_gfx,tunnel_gfx);    
    surface_free(surferino);
    }
    
}
    
    
ds_list_destroy(neighbour_list);
    
    
    
    
    
    
    
    
    
    
    
    
