/// string_split_to_array(Array, string)

//var array = argument[0];
var str = argument[0];
var dil = ",";
var array_temp = 0
var pos = string_pos(dil, str);
var dil_len = string_length(dil);


//remove the brackets on the end
str = string_copy(str, 3, string_length(str)-4)


//show_debug_message(str)

var array_y = string_count(" }",str)

for (var i = 0; i < array_y; i++){
  var array_pos = string_pos(" }, ", str)
  var str_temp = string_copy(str, 3, array_pos-3)
  var str = string_delete(str, 1, array_pos+3)
  
  //show_debug_message("str_temp = "+str_temp)
  //show_debug_message("str = "+str)
  
  var array_x = string_count(",", str_temp)
  pos = string_pos(dil, str_temp);
  
  for (var j = 0; j < array_x; j++){
      pos -= 1;
      array_temp[i,j] = real(string_copy(str_temp, 1, pos));
      str_temp = string_delete(str_temp, 1, pos + dil_len);
      pos = string_pos(dil, str_temp);
  }
  array_temp[i,j] = real(string_copy(str_temp, 1, string_length(str_temp)));
}
//show_debug_message(string(array_temp))

return array_temp;


//ds_list_add(rl, s);
/*
// create an array and store results:
var rn = ds_list_size(rl), rw;
if (os_browser != browser_not_a_browser) {
    rw[0] = rl[|0]; // initial allocation
    for (p = 1; p < rn; p++) rw[p] = rl[|p];
} else {
    p = rn; while (--p >= 0) rw[p] = rl[|p];
}

return array_temp;
