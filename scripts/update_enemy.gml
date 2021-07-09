///update_enemy(frames)

if !variable_instance_exists(self, "update_enemy_time"){
  update_enemy_time = 0
  self.enemy = nearest_enemy(x,y, one_chunk*2)
}

if (update_enemy_time >= argument0){
  update_enemy_time = 0
  
  ///if it's a summon with an owner, we will find an enemy closer to the owner ass apposed to the summon
  if (object_index = obj_summon)
  && (variable_instance_exists(self, "owner_id"))
  && instance_exists(owner_id){
    var xx = mean(owner_id.x, x)
    var yy = mean(owner_id.y, y)
    self.enemy = nearest_enemy(xx,yy, one_chunk*2)
  }else{
    self.enemy = nearest_enemy(x,y, one_chunk*2)
  }
  
}else{
  update_enemy_time += 1*lag()
}



