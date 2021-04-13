///update_enemy(frames)

if !variable_instance_exists(self, "update_enemy_time"){
  update_enemy_time = 0
  self.enemy = nearest_enemy(x,y, 16*50)
}

if (update_enemy_time >= argument0){
  update_enemy_time = 0
  self.enemy = nearest_enemy(x,y, 16*50)
}else{
  update_enemy_time += 1*lag()
}



