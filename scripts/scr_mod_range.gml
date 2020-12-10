///scr_mod_range
//
//melee
//weap spawn modifier

//use this varible to handle spawn times
///anim_attack_time

while !ds_queue_empty(self.recent_weap_queue){
  var _weap = ds_queue_dequeue(self.recent_weap_queue);
    
  _weap.melee_ranged += 1
  _weap.w_range = _weap.w_range*1.1
  _weap.w_damage = (_weap.w_damage/2)*1.1
}

ds_queue_copy(self.recent_weap_queue, self.weap_queue)

return true
