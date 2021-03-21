
if !debug_mode{
  if (string_pos("\AppData\Local\gm_ttt_", working_directory) = 0){
    return true;
  }
}

return false;

