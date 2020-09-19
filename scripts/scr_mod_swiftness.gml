///scr_mod_swiftness
//
//melee
//weap spawn modifier

//show_debug_message("swiftness")
while !ds_priority_empty(self.recent_weap_queue){
  self.weap_inst = ds_priority_delete_min(self.recent_weap_queue)
    
  self.weap_inst.swiftness += 1
  self.weap_inst.w_damage = ceil((self.weap_inst.w_damage/1.5)*1.1)
}

ds_priority_copy(self.recent_weap_queue, self.weap_queue)

return true
