///scr_mod_charged()


self.active_w_cooldown = 0
//increase damage (dps + 10%)
//increase knockback?

var mod_count = scr_queue_has_mod_count(self.active_queue, scr_mod_charged)
//show_debug_player(self.player_id_local, "mod_charge_count = "+string(mod_count))
  
self.mod_charge_timer += 1*lag()

//show_debug_player(self.player_id_local, "mod_charge_timer = "+string(self.mod_charge_timer))

if self.mod_charge_timer >= room_speed
{
  if (mod_count = 1){ //if this is our last charge
//    show_debug_message("last charge about to proc")
    if (self.repeater_in_queue = true) {return true}
    returned = false
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
    self.active_w_damage = (self.active_w_damage*8)*1.1
    return returned;
  }else{
  
//    show_debug_message("not last charge!!!")
    
    self.mod_charge_timer = 0
    self.active_w_damage = (self.active_w_damage*8)*1.1
    //show_debug_message("scr_mod_charged = charged")
    return 1
  }
} else {
  return 0
}
