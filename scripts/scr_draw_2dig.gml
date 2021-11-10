
if variable_instance_exists(id, "terrain_surface") && surface_exists(terrain_surface){
  draw_set_alpha(1)
  draw_surface(terrain_surface, x, y)
  draw_set_alpha(1)
}else{
  alarm_set(1,1)
}
