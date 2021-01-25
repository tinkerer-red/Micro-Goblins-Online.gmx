///htme_irandom(x)


// Returns a random integer between 0 and n. This includes n if n itself is an integer value.
if(variable_global_exists("htme_object")){
  
  global.num++
  htme_globalSet("num", global.num mod 1000,buffer_f32)
  
  //normalize the value into a percent
  var perc = normalize(global.rng[global.num mod 1000], 0, 1023)
  var value = argument0 * perc
  var value = floor(value+0.5)

}else{
  var value = irandom(argument0)
}
return value

