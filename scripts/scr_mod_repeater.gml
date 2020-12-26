///scr_mod_repeater()
//
//global
//button queue modifier

//reduce cool down
self.active_w_cooldown -= (room_speed/12) //2.5 for 30 fps
self.active_w_spawn_time_out -= (room_speed/20) //1.5 for 30 fps  (room_speed / 4 / 5)
self.active_w_damage = (self.active_w_damage*0.75)*1.1

//just making sure the player doesnt move while blasting away shit
spd = 0 
//show_debug_message("scr_mod_repeater")
return true

