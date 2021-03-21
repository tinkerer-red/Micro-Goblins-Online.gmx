///chunk_interior_cell_data_exists()

if (object_index = obj_chunk){
  if is_interior(){
    if variable_instance_exists(self, "interior_string"){
      if (interior_string != ""){
        //should_exist = false
        return true;
      }
    }
  }
}

//if any of the prior are false return false
return false;





//if we have made it this far, the object is a chunk, it's interior, and the interior_string doesnt exist on the chunk

//I suppose the responsible thing would be to check for the cell data inside the master list...

// nah
/////interior_string = room_grid[# interior_grid_x, interior_grid_y]
