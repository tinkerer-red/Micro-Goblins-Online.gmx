///htme_irandom_range(n1, n2)


// Returns a random integer between 0 and n. This includes n if n itself is an integer value.
if(variable_global_exists("htme_object")){

global.num++

//normalize the value into a percent
var perc = normalize(global.rng[global.num mod 1000], 0, 1023)
var range = argument1-argument0
var value = range * perc
var value = value + argument0
var value = floor(value+0.5)

}else{
  var value = irandom_range(argument0, argument1)
}

return value

