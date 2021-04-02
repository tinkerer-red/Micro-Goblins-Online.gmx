///cull_list_for_enemies(ds_list)

// cycles through a list removing anything which isn't an enemy

var list = argument0

if (ds_list_size(list) > 0){
  for (var i = ds_list_size(list)-1; i >= 0; i--){
    if (!is_enemy(list[| i])){
      ds_list_delete(list, i)
    }
  }
}
return list;
