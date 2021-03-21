///player_is_local([id])

if (argument_count = 1){
  _id = argument[0]
}else{
  _id = id
}

if (_id.object_index != obj_player)
|| (_id.player_id_local = -1){
  return false;
}

return true;
