///scr_mod_range
//
//melee
//weap spawn modifier

//use this varible to handle spawn times
///anim_attack_time


while !ds_queue_empty(self.recent_weap_queue){
  var _weap = ds_queue_dequeue(self.recent_weap_queue);
  
  //init
  if !variable_instance_exists(_weap, "mod_ranged_start"){
    _weap.mod_ranged_start = true
    _weap.proj_weapon_event_queues = ds_priority_create()
    ds_priority_copy(_weap.proj_weapon_event_queues, self.weapon_event_queues)
    
    //remove the projectile spawn modifiers since it shouldnt be possible for a melee weapon to have these modifiers
    ds_priority_delete_min(_weap.proj_weapon_event_queues)
  }

  _weap.melee_ranged += 1
  _weap.w_range = _weap.w_range*1.1
  _weap.w_damage = (_weap.w_damage/2)*1.1
}

ds_queue_copy(self.recent_weap_queue, self.weap_queue)

return true
