///item_is_equipable(item_nbt_data)

var item = argument0

var item_type = item[? "item_type"]

if (item_type = item_type_weapon_melee)
|| (item_type = item_type_weapon_range)
|| (item_type = item_type_weapon_summon)
|| (item_type = item_type_armor_head)
|| (item_type = item_type_armor_body)
|| (item_type = item_type_armor_boggle)
{
  return true;
}

var mods = item[? "modifiers"]

if (item_type = item_type_default)
&& (mods[? scr_mod_consume] = undefined){
  return false;
}else{
   return true;
}



