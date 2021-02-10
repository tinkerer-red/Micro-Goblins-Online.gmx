///draw_particle_paint(x1, y1)

if instance_exists(obj_particle_controller){
  
  var time_min = room_speed/6
  var time_max = room_speed/4
  
  var sprite = prt_dust2
  var x1 = argument[0]
  var y1 = argument[1]
  var color = c_white
  var radius = 4
  var size_increment = 4/room_speed
  
  var emit_time = 1
  
  //the particle type's string, used for key name, and checks
  var part_string = "part_type_dust"
  var emit_string = "part_emit_dust_"+string(x1 div (24+radius))+"_"+string(y1 div (24+radius))
  
  
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
    part_type_sprite(part_type, sprite, false, false, true)
    part_type_size(part_type, 0.0, 0.25, size_increment, 0.00)
    part_type_colour1(part_type, color)
    part_type_blend(part_type, false)
    part_type_alpha3(part_type, 1, 0.8, 0.0)
    part_type_direction(part_type, 0, 360, 0, 0)
    //part_type_gravity(part_type, 0.0, 0)
    //part_type_speed(part_type, 0.0, 0.0, 0.0, 0.0)
    part_type_life(part_type, time_min, time_max)
    part_type_orientation(part_type, 0, 360, 0.0, 0.0, false)
    
    
    
    /////Emitter/////
    
    ///create and map the emitter
    var part_emit = part_emitter_create(obj_particle_controller.part_sys)
    var part_emit_key = ds_map_create()
    ds_map_add(part_emit_key, "id", part_emit)
    ds_map_add(part_emit_key, "time", emit_time) //we only use one so it bursts once
    ds_map_add_map(part_type_key, emit_string, part_emit_key)
    
    //define variables for the particle emitter
    part_emitter_region(obj_particle_controller.part_sys, part_emit, x1-radius, x1+radius, y1-radius, y1+radius, ps_shape_ellipse, ps_distr_linear)
    part_emitter_burst(obj_particle_controller.part_sys, part_emit, part_type, 4)
    
    
    
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
      part_emitter_region(obj_particle_controller.part_sys, part_emit, x1-radius, x1+radius, y1-radius, y1+radius, ps_shape_ellipse, ps_distr_linear)
      part_emitter_burst(obj_particle_controller.part_sys, part_emit, part_type_key[? "id"], 4)
      
    }else{ //if the emitter is present in the particle type's map
      
      //add to the emitter's time
      var part_emit_key = part_type_key[? emit_string];
      part_emit_key[? "time"] = max(part_emit_key[? "time"], emit_time)
      part_emitter_burst(obj_particle_controller.part_sys, part_emit_key[? "id"], part_type_key[? "id"], 4)
    }
    
  }
  
}
