///show_debug_player(player_id_local, string)

if instance_exists(obj_debug)
{
  if htme_isLocal()
  {
    var pid = argument[0]
    if variable_instance_exists(obj_debug, "debug_string"){
      obj_debug.debug_string[pid] = obj_debug.debug_string[pid]+string(argument[1])+"#"
    }
  }
}
