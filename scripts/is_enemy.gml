///is_enemy(instance_id)

var target = argument[0];

/// if you have no owner, or the the target is not your owner
if (!variable_instance_exists(id, "owner_id") || owner_id != target){
      //if the target shares an owner with you
      if (variable_instance_exists(target, "owner_id") && variable_instance_exists(self, "owner_id")) && owner_id = target.owner_id{
         return false;
      }
      
      //if you are both a generic enemy
      if (target.object_index = obj_enemy){
        if (object_index = obj_enemy){
          return false;
        }else{
          return true;
        }
      }
      
      //if caller has no team
      if (!variable_instance_exists(id, "team") || team = team_none){
        return true;
      }else{
        
        //if the target has no team
        if !variable_instance_exists(target, "team") || team = team_none{
          return true;
        }else{
          
          //if the teams arent the same
          if (team != target.team){
            return true
          }else{
            
            //if they share a team
            return false;
          }
        }
      }
      
}else{
  return false;
}

      //this one shouldnt ever be returned but just incase it does anyways.
      return false;
