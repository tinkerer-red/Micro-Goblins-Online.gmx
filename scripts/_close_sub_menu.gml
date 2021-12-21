///_close_sub_menu()

//leave the sub menu
sub_menu_spawned[player_i] = false
sub_menu_anim_finished[player_i] = false
sub_menu_cursor_pos[player_i] = 0
in_sub_menu[player_i] = false
selected_item_map[player_i] = noone
surface_free(sub_menu_surface[player_i])
surface_free(lore_surface[player_i])
sub_menu_surface[player_i] = noone
lore_surface[player_i] = noone
