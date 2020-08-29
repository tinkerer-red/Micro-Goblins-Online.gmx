///scr_mod_charged()


self.active_w_cooldown = 0
//increase damage (dps + 10%)
//increase knockback?

self.mod_charge_timer += 1
//show_debug_player(self.player_id_local, "mod_charge_timer = "+string(self.mod_charge_timer))
if self.mod_charge_timer >= room_speed
{
  self.mod_charge_timer = 0
  self.active_w_damage = (self.active_w_damage*8)*1.1
  show_debug_message("scr_mod_charged = charged")
  return 1
} else {
  return 0
}
