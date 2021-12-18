///item_give_player(player_id, item)

var player = argument0
var item = argument1

var player_nbt = player.nbt
var inventory = player_nbt[? "inventory"]

//we clone the nbt data because the destroy event destroys the map too
ds_list_add(inventory, item)

obj_menu.update_menus = true;

