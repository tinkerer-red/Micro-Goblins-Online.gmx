///scr_mod_enlarge
//
//global
//weapon spawn modifier

//show_debug_message("shrink")
while !ds_queue_empty(self.recent_weap_queue){
  var _weap = ds_queue_dequeue(self.recent_weap_queue);
  
  if (_weap.image_xscale > 1){
    _weap.image_xscale -= 1 //_weap.image_xscale*1.5
    _weap.image_yscale -= 1 //_weap.image_yscale*1.5
  }else{
    _weap.image_xscale -= 0.1 //_weap.image_xscale*1.5
    _weap.image_yscale -= 0.1 //_weap.image_yscale*1.5
  }
  
  _weap.w_damage = ceil((_weap.w_damage/1.5)*1.1)
}

ds_queue_copy(self.recent_weap_queue, self.weap_queue)

return true


return true

