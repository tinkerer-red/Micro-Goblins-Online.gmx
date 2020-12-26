///draw_particle_circle(sprite, x1, y1, radius [time_min, time_max])

if instance_exists(obj_particle_controller){
  
  if (argument_count = 6){
    var time_min = argument[4]
    var time_max = argument[5]
  }else{
    var time_min = room_speed/6
    var time_max = room_speed/4
  }
  
  var sprite = argument[0]
  var x1 = argument[1]
  var y1 = argument[2]
  var radius = argument[3]
  
  var key = "part_circle_"+string(sprite)+string(x1)+string(y1)+string(radius)
  
  
  // if the map doesnt have the value add it to the map
  if (ds_map_find_value(obj_particle_controller.particle_map, key) = undefined){
    ds_map_add(obj_particle_controller.particle_map, key, time_max)
    
    var part_type = part_type_create()
    ds_map_add(obj_particle_controller.particle_map, key+"_type", part_type)
    
    //define variables for the particle type
    part_type_sprite(part_type, sprite, false, false, true)
    part_type_size(part_type, 0.5, 1, -0.01, 0.0)
    part_type_colour3(part_type, c_white, c_purple, c_purple)
    part_type_blend(part_type, true)
    part_type_alpha3(part_type, 0.9, 0.1, 0.25)
    part_type_direction(part_type, 90, 90, 0, 0.0)
    part_type_speed(part_type, 0.0, 1, 0.0, 0.0)
    part_type_life(part_type, time_min, time_max)
    
    
    var part_emitter = part_emitter_create(obj_particle_controller.part_sys)
    ds_map_add(obj_particle_controller.particle_map, key+"_emitter", part_emitter)
    
    //define variables for the particle emitter
    part_emitter_region(obj_particle_controller.part_sys, part_emitter, x1-radius, x1+radius, y1-radius, y1+radius, ps_shape_ellipse, ps_distr_invgaussian)
    part_emitter_stream(obj_particle_controller.part_sys, part_emitter, part_type, 2)
    
  }else{  //if the map already has the value reset the time for it
    obj_particle_controller.particle_map[? key] = max(obj_particle_controller.particle_map[? key], time_max)
  }
  
  
}
