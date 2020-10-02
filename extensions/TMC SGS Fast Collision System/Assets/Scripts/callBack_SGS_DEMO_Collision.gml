// callBack_SGS_DEMO_Collision(id)
/*

in this example the least amount of code is used for fast acting for the demo
using the variables provided.

*/
var iid = argument0;

//example checks
//
//if(iid.object_index == id.object_index) //equiv to same with same 
//if(object_is_ancestor(iid.object_index,a_parent_obj)) //equivalent to collision with parent
iid.x = iid.xstart;
iid.y = iid.ystart;

//you may check other setting like a team variable
//if(m_Team == iid.m_Team)
//...

//you may decide to break the looping or proceed
//stop right there, end the loop
return 1;
//allow continue to iterate through all other possible collisions
return 0;
