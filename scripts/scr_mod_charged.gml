///scr_mod_charged()



var mod_count = scr_queue_has_mod_count(self.active_queue, scr_mod_charged)

//init
if !variable_instance_exists(self, "mod_charge_start") || ((mod_charge_start = false) && (mod_charge_end = false)){
  mod_charge_start = true;
  mod_charge_end = false;
  
  mod_charge_time = room_speed*mod_count
  mod_charge_timer = 0
  mod_charge_audio_tick_timer = 0
  
  self.active_w_cooldown = 0
  
  repeat(mod_count){
    self.active_w_damage = (self.active_w_damage*8)*1.1
  }
  audio_play_sound(snd_mod_charge, 1,false)
  //increase knockback?
}


if (mod_charge_start){ //if the mod is active
    
    //remove all but one instance of this modifier
    if (mod_count = 1){
      mod_charge_start = true;
    }else{ //if we have more then a single mod in the queue remove them, because ideally we never need more then a single mod to handle anything
      return true
    }
    
    //iterate through the time
    self.mod_charge_timer += 1*lag()
    show_debug_player(self.player_id_local, "mod_charge_timer = "+string(self.mod_charge_timer))
    
    if self.mod_charge_timer >= mod_charge_time
    {
      //self.mod_charge_timer = 0;
      mod_charge_end = true;
      mod_charge_start = false;
    }
    
}


//play sound effects
if (instance_exists(obj_tick_handler)){
  if (obj_tick_handler.ticked_over){
    mod_charge_audio_tick_timer += 1
    
    var percent = mod_charge_timer/mod_charge_time
    var tick_event = ceil( lerp(obj_tick_handler.tps/3, 1, percent) )
    
    if (mod_charge_audio_tick_timer >= tick_event){
      mod_charge_audio_tick_timer -= tick_event
      audio_play_sound(snd_mod_charge, 1,false)
    }
    
  }
}


if (mod_charge_end){ //if mod is finished
  
  
  
  // if there is a repeater in the queue, just automatically finish the charge mod
  if (self.repeater_in_queue = true) {
    mod_charge_end = false;
    return true
  }
  
  
  //if there isnt a repeater, then wait until the button is actually released
  var returned = false
  switch (self.weap_num){
    case 0: 
      if !self.item_a {returned =  true};
    break;
    
    case 1: 
      if !self.item_b {returned =  true};
    break;
    
    case 2: 
      if !self.item_c {returned =  true};
    break;
    
    default: returned =  false;
  }
  
  if (returned){
    mod_charge_end = false;
  }
  
  return returned;
}


