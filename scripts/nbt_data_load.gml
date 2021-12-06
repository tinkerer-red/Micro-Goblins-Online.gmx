///nbt_data_load([file_name])


//this script loads the requested data, and if no data exists,
//  then it populates the list with either an empty map, or a debug map

if (argument_count = 1){
  var file_name = argument[0]
}else{
  var file_name = false
}


//if there is no file
if (file_name = false)
|| !file_exists(file_name){
  if is_released(){
    var nbt = _nbt_data_empty();
  }else{
    var nbt = _nbt_data_debug();
  }
}else{
  var nbt = file_load_map(file_name)
}


if !ds_map_exists(nbt, "max_inventory_slots"){
nbt[? "max_inventory_slots"] = 20
}
if !ds_map_exists(nbt, "inventory"){
nbt[? "inventory"] = ds_list_create()
}
/*
if !ds_map_exists(nbt, "armor_head"){
nbt[? "armor_head"] = 
}
if !ds_map_exists(nbt, "armor_body"){
nbt[? "armor_body"] = 
}
if !ds_map_exists(nbt, "armor_boggle"){
nbt[? "armor_boggle"] = 
}
if !ds_map_exists(nbt, "held_item_a"){
nbt[? "held_item_a"] = 
}
if !ds_map_exists(nbt, "held_item_b"){
nbt[? "held_item_b"] = 
}
if !ds_map_exists(nbt, "held_item_c"){
nbt[? "held_item_c"] = 
}
*/

//cycle through the inventory list and convert map strings into maps
var inv = nbt[? "inventory"]
var size = ds_list_size(inv)
for (var i = 0; i < size; i++){
  inv[| i] = json_decode(inv[| i])
}


return nbt












