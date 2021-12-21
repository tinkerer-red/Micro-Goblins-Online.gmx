///item_equip(nbt, equipment_slot, inventory_slot)

var nbt = argument0
var equipment_slot = argument1
var inv_slot = argument2

switch (equipment_slot){
  case equip.head:   var item_key = "armor_head";   break;
  case equip.body:   var item_key = "armor_body";   break;
  case equip.boggle: var item_key = "armor_boggle"; break;
  case equip.item_a: var item_key = "held_item_a";  break;
  case equip.item_b: var item_key = "held_item_b";  break;
  case equip.item_c: var item_key = "held_item_c";  break;
  default:           var item_key = "";             break; //this is only here to prevent reading from a bad section of ram
}

//grab the item
var equipment_item = nbt[? item_key];

var inventory = nbt[? "inventory"];
var inv_item = inventory[| inv_slot];

nbt[? item_key] = inv_item

//if there is something in the equipment slot
if (ds_map_exists(nbt, item_key))
&& (equipment_item != undefined)
&& ds_exists(equipment_item, ds_type_map){
  
  //move the equipment item into the inventory
  inventory[| inv_slot] = equipment_item
  
}else{  //if there is nothing inside the equipment slot
  
  //then delete the original listing of the inventory item to prevent item duping
  ds_list_delete(inventory, inv_slot)
}

obj_menu.update_menus = true
