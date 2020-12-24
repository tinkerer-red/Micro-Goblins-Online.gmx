///draw_particle_line(sprite, x1, y1, x2, y2, [time_min, time_max])

if instance_exists(obj_particle_controller){
  
  if (argument_count = 7){
    var time_min = argument[5]
    var time_max = argument[6]
  }else{
    var time_min = room_speed*0.1
    var time_max = room_speed*0.25
  }
  
  var sprite = argument[0]
  var x1 = argument[1]
  var y1 = argument[2]
  var x2 = argument[3]
  var y2 = argument[4]
  
  var key = "part_line_"+string(sprite)+string(x1)+string(y1)+string(x2)+string(y2)
  
  
  // if the map doesnt have the value add it to the map
  if (ds_map_find_value(obj_particle_controller.particle_map, key) = undefined){
    ds_map_add(obj_particle_controller.particle_map, key, time_max)
    
    var part_type = part_type_create()
    ds_map_add(obj_particle_controller.particle_map, key+"_type", part_type)
    
    //define variables for the particle type
    part_type_sprite(part_type, sprite, true, true, false)
    part_type_size(part_type, 0.25, 0.5, 0, 0.02)
    part_type_colour3(part_type, c_red, c_orange, c_white)
    part_type_blend(part_type, false)
    part_type_alpha3(part_type, 0.5, 0.75, 0.0)
    part_type_direction(part_type, 0, 360, 0, 0.02)
    part_type_speed(part_type, 0.5, 1, -0.1, 0.05)
    part_type_life(part_type, time_min, time_max)
    
    
    var part_emitter = part_emitter_create(obj_particle_controller.part_sys)
    ds_map_add(obj_particle_controller.particle_map, key+"_emitter", part_emitter)
    
    //define variables for the particle emitter
    part_emitter_region(obj_particle_controller.part_sys, part_emitter, x1, x2, y1, y2, ps_shape_line, ps_distr_linear)
    part_emitter_stream(obj_particle_controller.part_sys, part_emitter, part_type, 1)
    
  }else{  //if the map already has the value reset the time for it
    obj_particle_controller.particle_map[? key] = max(obj_particle_controller.particle_map[? key], time_max)
  }
  
  
}
