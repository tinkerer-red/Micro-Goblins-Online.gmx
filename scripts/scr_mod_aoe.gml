///scr_mod_aoe
//
//collision modifier

//show_debug_message("scr_mod_aoe")

var mod_count = scr_queue_has_mod_count(active_queue, scr_mod_aoe)

///define variables on first launch
if !variable_instance_exists(self.id, "aoe_start"){
  self.aoe_start = true
  
  w_damage *= .85
  
  var mod_aoe_mod_count = scr_queue_has_mod_count(active_queue, scr_mod_aoe)
  
  //check for Continuous
  if variable_instance_exists(self.id, "continuous_start"){
    has_continuous = true;
  }else{
    has_continuous = false;
  }
  
  //transform
  speed = 0
  sprite_index = sprite_aoe
  image_xscale += (mod_aoe_mod_count-1)*.5
  image_yscale += (mod_aoe_mod_count-1)*.5
  mod_aoe_radius = mean(sprite_width, sprite_height)/2
  max_image_scale = mean(image_xscale, image_yscale)
  image_xscale = .25
  image_xscale = .25
  image_alpha = 0
  mod_aoe_expansion_time = room_speed*.6
  mod_aoe_expansion_timer = 0
  
  
  
  if not has_continuous{
    mod_aoe_list = collision_circle_list(x, y, mod_aoe_radius, obj_entity, -1, true)
    
    if (mod_aoe_list != noone){ //if the list is populated
      cull_list_for_enemies(mod_aoe_list)
      
      for(var i = ds_list_size(mod_aoe_list)-1; i >= 0; i--){
        enemy = mod_aoe_list[| i]
        deal_damage(enemy, w_damage)
      }
      
      ds_list_destroy(mod_aoe_list)
    }
  }
  else //if has continuous
  {
    w_damage *= .75
    mod_aoe_list_restock_time = room_speed*.2
    mod_continuous_time = mod_continuous_timer
  }
}


if (mod_count != 1){
  return true;
}



if self.aoe_start {
  if not has_continuous{
    mod_aoe_expansion_timer += 1*lag()
    
    //this variable is used to make the first and last 20% of the time, to fade in and out the image
    var visual_percent = (mod_aoe_expansion_timer/mod_aoe_expansion_time)*5
    if (visual_percent >= 4) {
      visual_percent = abs((visual_percent/5)-1)*5
    }
    
    image_alpha = clamp(visual_percent, 0, 1)
    image_angle += 5
    
    //this variable is used to adjust the aoe size
    var size_multiplier = mod_aoe_expansion_timer/(mod_aoe_expansion_time*.5)
    var scale = max_image_scale*clamp(size_multiplier, 0, 1)
    image_xscale = scale
    image_yscale = scale
    
    if (mod_aoe_expansion_timer >= mod_aoe_expansion_time){
      return true;
    }
  }
  else //if has continuous
  {
    ///visual shit
    //this variable is used to make the first and last 20% of the time, to fade in and out the image
    var visual_percent = (mod_continuous_timer/mod_continuous_time)*10
    if (visual_percent >= 9) {
      visual_percent = abs((visual_percent/10)-1)*10
    }
    
    image_alpha = clamp(visual_percent, 0, 1)
    image_angle += 5
    
    //this variable is used to adjust the aoe size
    var size_multiplier = mod_continuous_timer/(mod_continuous_time*.2)
    var scale = max_image_scale*clamp(size_multiplier, 0, 1)
    image_xscale = scale
    image_yscale = scale
    
    
    
    
    
    //only restock the list once in a while instead of every frame
    var last_mod_value    = mod_continuous_timer mod mod_aoe_list_restock_time;
    mod_continuous_timer -= 1*lag()
    var current_mod_value = mod_continuous_timer mod mod_aoe_list_restock_time;
    
    if (current_mod_value != last_mod_value){
      var update_col_list = true
    }else{
      var update_col_list = false
    }
    
    if (update_col_list){
      //collision checks and damage
      mod_aoe_list = collision_circle_list(x, y, mod_aoe_radius, obj_entity, -1, true)
      
      if (mod_aoe_list != noone){ //if the list is populated
        cull_list_for_enemies(mod_aoe_list)
        
        for(var i = ds_list_size(mod_aoe_list)-1; i >= 0; i--){
          enemy = mod_aoe_list[| i]
          deal_tick_damage(enemy, w_damage, room_speed*.33, owner_id)
        }
        
        ds_list_destroy(mod_aoe_list)
      }
    }
    
    //decrement timer
    if (mod_continuous_timer <= 0){
      return true;
    }
    
  }
}


return false;
