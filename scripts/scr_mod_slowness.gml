///scr_mod_slowness
//
//melee
//weap spawn modifier


while !ds_priority_empty(self.recent_weap_queue){
  self.weap_inst = ds_priority_delete_min(self.recent_weap_queue)
  
  self.weap_inst.slowness += 1
  self.weap_inst.w_damage = ceil((self.weap_inst.w_damage*1.5)*1.1)
}

ds_priority_copy(self.recent_weap_queue, self.weap_queue)

return true
