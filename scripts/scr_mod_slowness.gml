///scr_mod_slowness
//
//melee
//weap spawn modifier


while !ds_queue_empty(self.recent_weap_queue){
  var _weap = ds_queue_dequeue(self.recent_weap_queue);
  
  _weap.slowness += 1
  _weap.w_damage = ceil((_weap.w_damage*1.5)*1.1)
}

ds_queue_copy(self.recent_weap_queue, self.weap_queue)

return true
