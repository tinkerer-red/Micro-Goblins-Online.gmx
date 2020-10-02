/// sgs_place_meeting_c(sgs_field, x, y, obj);
/*
The _c (cell) varient performs the check only in the current cell
without accounting for cell overlap for the calling instance
which may be prone to errors but is faster


read GML documentation for place_meeting

Checks for a collision between two instances at a given position

sgs_field is the field to use for segregated check
note, for speed sake the code assumes everything is good with the data structures

if you plan to destroy the instance, use the _s (Safe) variant

retuns the true or or false

*/
return (sgs_instance_place_c(argument0,argument1,argument2,argument3) != noone);
