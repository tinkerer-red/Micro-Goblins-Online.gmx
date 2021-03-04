///draw_particle_dashLines(x1, y1, x2, y2 [time_min, time_max])

if instance_exists(obj_particle_controller){
  
  if (argument_count = 6){
    var time_min = argument[4]
    var time_max = argument[5]
  }else{
    var time_min = room_speed/5
    var time_max = room_speed/5
  }
  
  var sprite = prt_dashLines
  var x1 = argument[0]
  var y1 = argument[1]
  var x2 = argument[2]
  var y2 = argument[3]
  var color = c_white
  var radius = 0
  
  var _dir = point_direction(x1,y1, x2, y2)
  
  var emit_time = 1
  
  //the particle type's string, used for key name, and checks
  var part_string = "part_type_dashLines_"+string(x1 div 64)+string(y1 div 64)
  var emit_string = "part_emit_dashLines_"+string(x1 div 64)+"_"+string(y1 div 64)
  
  
  // if the map doesnt have the value add it to the map
  if (ds_map_find_value(obj_particle_controller.particle_map, part_string) = undefined){
    
    /////Particle Type/////
    
    //create and map the part type
    var part_type = part_type_create()
    var part_type_key = ds_map_create()
    ds_map_add(part_type_key, "id", part_type)
    ds_map_add(part_type_key, "time", time_max)
    ds_map_add_map(obj_particle_controller.particle_map, part_string, part_type_key)
    
    //define variables for the particle type
    part_type_sprite(part_type, sprite, true, true, false)
    part_type_size(part_type, 1, 1, 0, 0.00)
    part_type_scale(part_type, 0.75, 0.666);
    part_type_colour1(part_type, color)
    part_type_blend(part_type, false)
    part_type_alpha2(part_type, 1, 0)
    ///part_type_direction(part_type, _dir, _dir, 0, 0)
    //part_type_gravity(part_type, 0.0, 0)
    //part_type_speed(part_type, 0.0, 0.0, 0.0, 0.0)
    part_type_life(part_type, time_min, time_max)
    part_type_orientation(part_type, _dir, _dir, 0.0, 0.0, false)
    
    
    
    /////Emitter/////
    
    ///create and map the emitter
    var part_emit = part_emitter_create(obj_particle_controller.part_sys)
    var part_emit_key = ds_map_create()
    ds_map_add(part_emit_key, "id", part_emit)
    ds_map_add(part_emit_key, "time", emit_time) //we only use one so it bursts once
    ds_map_add_map(part_type_key, emit_string, part_emit_key)
    
    //define variables for the particle emitter
    part_emitter_region(obj_particle_controller.part_sys, part_emit, x1-radius, x1+radius, y1-radius, y1+radius, ps_shape_rectangle, ps_distr_linear)
    part_emitter_burst(obj_particle_controller.part_sys, part_emit, part_type, 1)
    
    
    
  }else{  //if the map already has the value reset the time for it
    var part_type_key = obj_particle_controller.particle_map[? part_string];
    
    part_type_key[? "time"] = max(part_type_key[? "time"], time_max)
    
    //if the map doesn't have this current emitter create it and map it
    if (ds_map_find_value(part_type_key, emit_string) = undefined){
      /////Emitter/////
      
      ///create and map the emitter
      var part_emit = part_emitter_create(obj_particle_controller.part_sys)
      var part_emit_key = ds_map_create()
      ds_map_add(part_emit_key, "id", part_emit)
      ds_map_add(part_emit_key, "time", emit_time) //we only use one so it bursts once
      ds_map_add_map(part_type_key, emit_string, part_emit_key)
      
      //define variables for the particle emitter
      part_emitter_region(obj_particle_controller.part_sys, part_emit, x1-radius, x1+radius, y1-radius, y1+radius, ps_shape_rectangle, ps_distr_linear)
      part_emitter_burst(obj_particle_controller.part_sys, part_emit, part_type_key[? "id"], 1)
      
    }else{ //if the emitter is present in the particle type's map
      
      //add to the emitter's time
      var part_emit_key = part_type_key[? emit_string];
      part_emit_key[? "time"] = max(part_emit_key[? "time"], emit_time)
    }
    
  }
  
}
