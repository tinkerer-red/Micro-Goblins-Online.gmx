///show_debug_player(player_id_local, string)

if instance_exists(obj_debug_new)
{
  if htme_isLocal()
  {
    if (argument_count = 2){
      var pid = argument[0]
      if variable_instance_exists(obj_debug_new, "debug_string"){
        obj_debug_new.debug_string[pid] = obj_debug_new.debug_string[pid]+string(argument[1])+"#"
      }
    }else{
      var pid = 0
      if variable_instance_exists(obj_debug, "debug_string"){
        obj_debug_new.debug_string[pid] = obj_debug_new.debug_string[pid]+string(argument[0])+"#"
      }
    }
  }
}


