///scr_mod_slowness
//
//melee
//weap spawn modifier


self.weap_inst.slowness += 1
self.weap_inst.w_damage = ceil((self.weap_inst.w_damage*1.5)*1.1)

return true
