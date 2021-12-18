///item_is_armor(item_nbt_data)

var item = argument0

var item_type = item[? "item_type"]

if (item_type = item_type_armor_head)
|| (item_type = item_type_armor_body)
|| (item_type = item_type_armor_boggle)
{
  return true;
}else{
  return false;
}
