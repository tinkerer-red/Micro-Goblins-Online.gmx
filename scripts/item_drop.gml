///item_drop(player_id, inventory_slot)


//find the player
var player = argument0
var inv_pos = argument1

var _nbt = player.nbt


//delete the item from the inventory
if (inv_pos < 6){
  switch (inv_pos){
    case equip.head:   var item_key = "armor_head";   break;
    case equip.body:   var item_key = "armor_body";   break;
    case equip.boggle: var item_key = "armor_boggle"; break;
    case equip.item_a: var item_key = "held_item_a";  break;
    case equip.item_b: var item_key = "held_item_b";  break;
    case equip.item_c: var item_key = "held_item_c";  break;
    default:           var item_key = "";             break; //this is only here to prevent reading from a bad section of ram
  }
  var _item = _nbt[? item_key]
  ds_map_delete(_nbt, item_key)

}else{
  var _inv = _nbt[? "inventory"]
  var _item = _inv[| inv_pos-6]
  ds_list_delete(_inv, inv_pos-6)
}


//spawn the item
item_spawn(_item, player.x, player.y, 5, player.direction, player)


//update the menu
update_menus = true
