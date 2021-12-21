///item_unequip(player, equipment_slot)

var player = argument0
var nbt = player.nbt
var equipment_slot = argument1

switch (equipment_slot){
  case equip.head:   var item_key = "armor_head";   break;
  case equip.body:   var item_key = "armor_body";   break;
  case equip.boggle: var item_key = "armor_boggle"; break;
  case equip.item_a: var item_key = "held_item_a";  break;
  case equip.item_b: var item_key = "held_item_b";  break;
  case equip.item_c: var item_key = "held_item_c";  break;
  default:           var item_key = "";             break; //this is only here to prevent reading from a bad section of ram
}

//grab the item we want to handle
var equipment_item = nbt[? item_key];


//check to make sure there is room for the item
var max_inventory_slots = nbt[? "max_inventory_slots"]
var inventory = nbt[? "inventory"];

//if the inventory has room
if (ds_list_size(inventory) < max_inventory_slots){
  
  ds_list_add(inventory, equipment_item)
  
}else{//if the inventory is full, then drop the item
  
  //drop the item here
  item_drop(player, equipment_slot)
}

//remove the key from the nbt data for the equipment slot
ds_map_delete(nbt, item_key)


obj_menu.update_menus = true
