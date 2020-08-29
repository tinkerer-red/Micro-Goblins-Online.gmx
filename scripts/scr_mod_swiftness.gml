///scr_mod_swiftness
//
//melee
//weap spawn modifier


self.weap_inst.swiftness += 1
self.weap_inst.w_damage = ceil((self.weap_inst.w_damage/1.5)*1.1)

return true
