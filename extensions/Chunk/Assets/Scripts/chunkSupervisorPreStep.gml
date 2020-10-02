callChunk(mouse_x,mouse_y);

//only make visible those chunks that are close enough to the mouse_x, mouse_y


//this will only deactivate it, so they're not drawn or processing stuff.
//the larger radius will determine whether they should exist at all -
//unless their always_loaded flag is set to true.
//instance_deactivate_object(objChunk);

//instance_activate_region(mouse_x-global.chunk_length*4,mouse_y-global.chunk_length*4,mouse_x+global.chunk_length*8,mouse_y+global.chunk_length*8,true);

/*
with (objChunk)
{
visible=0;

if (point_distance(x+global.chunk_length/2,y+global.chunk_length/2,mouse_x,mouse_y)<=8*global.chunk_length)
    {
    visible=1;
    }
}
