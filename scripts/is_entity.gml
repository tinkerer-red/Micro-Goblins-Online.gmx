///is_entity(obj)

//returns true if it or one of it's parents are an entity

var target = argument0
var new_parent = object_get_parent(target.object_index);

if not ((new_parent = -100) || (new_parent = -1)){
  do{
    var temp_parent = new_parent;
    var new_parent = object_get_parent(temp_parent);
  }
  until ((new_parent = -100) || (new_parent = -1));
  
  //once we reach the end of the parents
  if (temp_parent = obj_entity){
    return true
  }else{
    return false
  }
  
}else{ //if it has no parents
  if (target.object_index = obj_entity){
    return true
  }else{
    return false
  }
}

return false;
