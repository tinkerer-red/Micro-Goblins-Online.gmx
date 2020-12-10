///scr_mod_chained()
//
//melee
//weap spawn modifier

//show_debug_message("chained mod")

while !ds_queue_empty(self.recent_weap_queue){
  var weap = ds_queue_dequeue(self.recent_weap_queue);
  
  //weap.swiftness += 0.1
  weap.dis += ((self.sprite_width*self.image_xscale)/2 + (self.sprite_height*self.image_yscale)/2)/*/2*/ +1;
  weap.w_damage = ceil((weap.w_damage/1.5)*1.1);
  
  weap.is_chained = true
}

ds_queue_copy(self.recent_weap_queue, self.weap_queue)

return true
