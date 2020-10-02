/// sgs_place_meeting_c_s(sgs_field, x, y, obj);
/*
The _c (cell) varient performs the check only in the current cell
without accounting for cell overlap for the calling instance
which may be prone to errors but is faster


The _s (Safe) varient performs the place_meeting first 
which ensure the instance stored in the cell still exists
use this version if you instance_destroy() the returned id

read GML documentation for place_meeting

Checks for a collision between two instances at a given position

sgs_field is the field to use for segregated check
note, for speed sake the code assumes everything is good with the data structures

retuns the true or or false

*/
return (sgs_instance_place_c_s(argument0,argument1,argument2,argument3) != noone);
