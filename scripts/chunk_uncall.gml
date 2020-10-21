///chunk_uncall(cell_x, cell_y)

var cell_x = argument0;
var cell_y = argument1;


with (obj_chunk){
  if (generated = false) || (chunk_data = -1){
    should_exist = false;
    event_user(1)
    return true;
  }
  
  if (chunk_x = cell_x) && (chunk_y = cell_y) {
    alarm_set(3,1);
    return true;
  }
}

return false;



