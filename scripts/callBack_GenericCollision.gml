// callBack_GenericCollision(id)
/*
example of a collision emu callback script
id is the instance the current instance is touching

Clone this script and change the values below to match your collision event

If you want to be a little lazy you can paste you original collision code in the section below
and delete your original collision event of course... Be aware doing this (the with calls) is 
somewhat slower than directly handling the event directly using the supplied iid...
*/

var iid = argument0;

var me = id;

var collideswith;

//handle id collides with object_index, example here for sgs_demo_obj_ai
//event start
collideswith = obj_solid; //set to the object type you want to handle
//use this if to support parent collision
//if(iid.object_index == collideswith || object_is_ancestor(iid.object_index,collideswith))
//use this if to only support only collisionn with actual object
if(iid.object_index == collideswith)
{
    with(me)
    {
        with(iid)
        {
            //paste your code here for collision event that applies to OTHER, self, other will be valid as in the collision event
            //or
            with(me)
            {
                //paste your code here for collision event that applies to SELF, self, other will be valid as in the collision event
                other.x = random(room_width)//other.xstart;
                other.y = random(room_height)//other.ystart;
            }
        }
    }
}
//event end
//copy and paste for other collision events, though ultimatly you could have multple sgs fields and do on type per field
//...
//stop right here. no sense proceeding
return 1;
//or allow continue like gm does (slower, collision action for all)
return 0;
