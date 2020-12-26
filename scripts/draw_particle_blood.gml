///draw_particle_blood(x, y)

if instance_exists(obj_particle_controller){
  
  var sprite = prt_liquidball
  var x1 = argument[0]
  var y1 = argument[1]
  
  var time_min = room_speed/6
  var time_max = room_speed/2
  
  //the particle type's string, used for key name, and checks
  var part_string = "part_type_blood"
  var emit_string = "part_emit_"+string(round(x1))+"_"+string(round(y1))
  
  
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
    part_type_size(part_type, 0.01, 1, 0, 0.00)
    part_type_colour3(part_type, c_red, c_red, c_red)
    part_type_blend(part_type, false)
    part_type_alpha3(part_type, 1, 1, 0.75)
    part_type_direction(part_type, 0, 180, 0, 0)
    part_type_gravity(part_type, 0.1, 270)
    part_type_speed(part_type, 0.5, 1.5, 0, 0)
    part_type_life(part_type, time_min, time_max)
    
    
    
    /////Emitter/////
    
    ///create and map the emitter
    var part_emit = part_emitter_create(obj_particle_controller.part_sys)
    var part_emit_key = ds_map_create()
    ds_map_add(part_emit_key, "id", part_emit)
    ds_map_add(part_emit_key, "time", 1) //we only use one so it bursts once
    ds_map_add_map(part_type_key, emit_string, part_emit_key)
    
    //define variables for the particle emitter
    part_emitter_region(obj_particle_controller.part_sys, part_emit, x1, x1, y1, y1, ps_shape_rectangle, ps_distr_linear)
    part_emitter_burst(obj_particle_controller.part_sys, part_emit, part_type, 8)
    
    
    
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
      ds_map_add(part_emit_key, "time", 1) //we only use one so it bursts once
      ds_map_add_map(part_type_key, emit_string, part_emit_key)
      
      //define variables for the particle emitter
      part_emitter_region(obj_particle_controller.part_sys, part_emit, x1, x1, y1, y1, ps_shape_rectangle, ps_distr_linear)
      part_emitter_burst(obj_particle_controller.part_sys, part_emit, part_type_key[? "id"], 8)
    
    }else{ //if the emitter is present in the particle type's map
      
      //add to the emitter's time
      var part_emit_key = part_type_key[? emit_string];
      part_emit_key[? "time"] = max(part_emit_key[? "time"], time_max)
    }
    
  }
  
}
