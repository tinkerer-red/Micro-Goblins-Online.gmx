
if variable_instance_exists(id, "terrain_surface") && surface_exists(terrain_surface){
  draw_surface(terrain_surface, x, y)
  
}else{
  alarm_set(1,1)
}
