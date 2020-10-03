///chunk_uncall(cell_x, cell_y)

var cell_x = argument0;
var cell_y = argument1;

//if the cell already exists, dont try to make a new one
with (obj_chunk){
  if (chunk_x = cell_x) && (chunk_y = cell_y) {
    alarm_set(3,1);
    return true;
  }
}

return false;



