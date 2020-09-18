///htme_choose(val0, val1, val2... max_val);


// Returns a random integer between 0 and n. This includes n if n itself is an integer value.

//these are only here because the compiler wants them to be here
if (argument_count = 1) var a0 = argument0
if (argument_count = 2) var a1 = argument1
if (argument_count = 3) var a2 = argument2
if (argument_count = 4) var a3 = argument3
if (argument_count = 5) var a4 = argument4
if (argument_count = 6) var a5 = argument5
if (argument_count = 7) var a6 = argument6
if (argument_count = 8) var a7 = argument7
if (argument_count = 9) var a8 = argument8
if (argument_count = 10) var a9 = argument9
if (argument_count = 11) var a10 = argument10
if (argument_count = 12) var a11 = argument11
if (argument_count = 13) var a12 = argument12
if (argument_count = 14) var a13 = argument13
if (argument_count = 15) var a14 = argument14
if (argument_count = 16) var a15 = argument15
//sorry about that

global.num++

//normalize the value into a percent
var perc = normalize(global.rng[global.num mod 1000], 0, 1023)
var range = argument_count-1
var value = range * perc

var value = floor(value+0.5)


return argument[value]

