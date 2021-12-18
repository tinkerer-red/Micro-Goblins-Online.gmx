///item_is_consumable(item_nbt_data)

var item = argument0
var mods = item[? "modifiers"]

if (mods[? scr_mod_consume] = undefined){
  return false;
}else{
   return true;
}



