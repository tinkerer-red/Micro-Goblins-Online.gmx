/// sgs_place_meeting(sgs_field, x, y, obj);
/*
read GML documentation for place_meeting

Checks for a collision between two instances at a given position

sgs_field is the field to use for segregated check
note, for speed sake the code assumes everything is good with the data structures

if you plan to destroy the instance, use the _s (Safe) variant

retuns the true or or false

*/
return (sgs_instance_place(argument0,argument1,argument2,argument3) != noone);
