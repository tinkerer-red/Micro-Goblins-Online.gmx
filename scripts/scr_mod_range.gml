///scr_mod_range
//
//melee
//weap spawn modifier

while !ds_priority_empty(self.recent_weap_queue){
  self.weap_inst = ds_priority_delete_min(self.recent_weap_queue)
    
  self.weap_inst.melee_ranged += 1
  self.weap_inst.w_range = self.weap_inst.w_range*1.1
  self.weap_inst.w_damage = (self.weap_inst.w_damage/2)*1.1
}

ds_priority_copy(self.recent_weap_queue, self.weap_queue)

return true
