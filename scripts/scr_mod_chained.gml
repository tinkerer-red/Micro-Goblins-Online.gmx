///scr_mod_chained()
//
//melee
//weap spawn modifier

while !ds_priority_empty(self.recent_weap_queue){
  self.weap_inst = ds_priority_delete_min(self.recent_weap_queue)
  
  //self.weap_inst.swiftness += 0.1
  self.weap.dis += ((self.sprite_width*self.image_xscale)/2 + (self.sprite_height*self.image_yscale)/2)/*/2*/ +1
  self.weap_inst.w_damage = ceil((self.weap_inst.w_damage/1.5)*1.1)
  
  self.weap.is_chained = true
}

ds_priority_copy(self.recent_weap_queue, self.weap_queue)

return true
