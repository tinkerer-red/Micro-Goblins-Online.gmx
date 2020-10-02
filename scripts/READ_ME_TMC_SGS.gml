/*
TMC_SGS works to improve the collision speed from Studio's default collision system.

You need to be aware of the how things work to allow for a proper porting from Studio's collision event to the TMC_SGS system.

first in a controller object, you create a sgs field

on room_start or create:
[code]
global.ai_sgs_field = sgs_field_create(sgs_demo_obj_ai,256);
[/code]

where sgs_demo_obj_ai is the target object, can be a parent or a specify object

where 256 is the size of the grid cells for the room, this value should be twice 
as large as your largest object and big enough the encompass the target object speed. 
having this too small may cause skipping, lag the system or even fail if the number 
of generated cells is too enormous, for example if your room is 100000x1000000 and 
your cell size is 32, that would make 9765625 cells

Do this for every collision types you wish to convert to, using another global for 
each types, ultimately you may use parenting and only have one field, it's up to you. 
You can segregate the object type either in the collision_check function or the 
collision event callback script later.

[code]
global.ai1_sgs_field = sgs_field_create(sgs_demo_obj_ai2,256);
global.ai2_sgs_field = sgs_field_create(sgs_demo_obj_ai3,413);
global.ai3_sgs_field = sgs_field_create(sgs_demo_obj_ai4,128);
[/code]

or
[code]
global.all_ais_sgs_field = sgs_field_create(sgs_demo_obj_ai_parent_obj,256);
[/code]

Note that having multiple fields you can set the cell size to a different values 
depending on the circonstances


if the cell size is too large, like the same size are the room, then well then the 
system will act in a manner similar to Studio's collision system and give no benefits

Second you need an initial step iteration, you call this after you create the field 
and every step or end step:
[code]
sgs_step(global.ai_sgs_field,(1000000/room_speed) * frameskip);
[/code]

where global.ai_sgs_field is the field you created and frameskip is the number of 
frames to skip, it is a good idea to allow frame skipping so the system does not bog 
down the cpu especially if not running under YYC calculating the field content each step

Do this for every field you created...
[code]
sgs_step(global.ai1_sgs_field,(1000000/room_speed) * 4);
sgs_step(global.ai2_sgs_field,(1000000/room_speed) * 6);
sgs_step(global.ai3_sgs_field,(1000000/room_speed) * 8);
[/code]

or
[code]
sgs_step(global.all_ais_sgs_field,(1000000/room_speed) * frameskip);
[/code]

Your cell size and the frameskip act as a compromise and you have to take the object 
size, speed and the frameskip into consideration. for example if your object is 200x200 
and travels at 100 in speed (unlikely) and your framskip is 6, meaning it fills the cells 
every 6 frames, then your object may have traveled 600 pixels and so your cell size should 
be 600+200....

You have to test and tweak until you are satisfied there is no skiping in collision and the 
framerate is optimal. Be sure to have a debug output for fps_real and tweak until it is the 
largest value

Note that having multiple fields you can set the skipping to a different values depending on 
the circonstances

If you are replacing collision events with SGS:
In your object that has the collision event you wish to replace with sgs, copy the collision 
event code,
duplicate
callBack_GenericCollision script, 
name it obj_collides_with_obj, for example bullet_collides_with_ship

delete the original collision event, ultimately you can change the event to user even 0 or 
whatnot to keep the code intact if you want to revert later.

Paste the code in the callback script at the location preferable to your situation, see the 
script for more details.... and type in the object name or parent object name for the 
collideswith object you are handing. If your object has multiple collision event, copy and 
paste the code section to handle all the other object, and nuke the collision events in the 
object of course.

Now in your object, add a end step event if you did not have one and add the code that will 
emulate the collision event.

[code]
if(sgs_collision_event_emu(global.ai_sgs_field,bullet_collides_with_ship))
{
    alarm[0] = 1;
}
[/code]

if you have separate field, do this for every field... 

Collision Functions:
If you are replacing a collision function with a sgs equivalent, simply call the scrip match 
the function you want. For the function to work, the sgs field must have the object in question 
in the cells of course

[code]
if(sgs_collision_point(global.ai_sgs_field ,x,y,obj_ai,0,1))
{
 //collision point here.
}
[/code]


*/
