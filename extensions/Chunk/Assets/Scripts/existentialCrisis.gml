//the chunk is asking itself a question:
//what am I doing here? Should I even exist?

var centrey_x=x+global.chunk_length/2;
var centrey_y=y+global.chunk_length/2;

if !(point_in_rectangle(centrey_x,centrey_y,mouse_x-7*global.chunk_length,mouse_y-7*global.chunk_length,mouse_x+14*global.chunk_length,mouse_y+14*global.chunk_length))
    {
    //BUT WAIT. Maybe some entities need me?
    var go_ahead_unload=true;
    if (instance_number(objAnt)>0)
        {
        var nearest=instance_nearest(centrey_x,centrey_y,objAnt);
        if (point_distance(centrey_x,centrey_y,nearest.x,nearest.y)<=global.chunk_length*2)
            {
            go_ahead_unload=false;
            }       
        }
    
    if (go_ahead_unload==true)
    chunkUnload();
    }
