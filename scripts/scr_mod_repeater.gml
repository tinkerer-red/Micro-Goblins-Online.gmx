///scr_mod_repeater()
//
//global
//button queue modifier

var mod_count = scr_queue_has_mod_count(active_queue, scr_mod_repeater)

//init
if !variable_instance_exists(self, "mod_repeater_start") || (mod_repeater_start = false){
  mod_repeater_start = true
  
//reduce cool down
self.active_w_cooldown -= (room_speed/12)*mod_count //2.5 for 30 fps
self.active_w_spawn_time_out = clamp(self.active_w_spawn_time_out-(room_speed/20)*mod_count, 1, self.active_w_spawn_time_out) //1.5 for 30 fps  (room_speed / 4 / 5)
self.active_w_damage = (self.active_w_damage*0.75)*1.1
}

if (mod_count = 1){
  mod_repeater_start = false
}

//just making sure the player doesnt move while blasting away shit
spd = 0 
//show_debug_message("scr_mod_repeater")
return true

