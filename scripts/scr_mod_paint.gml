///scr_mod_paint
//
//collision modifier

//show_debug_message("scr_mod_paint")

var returned = false


///define variables on first launch
if !variable_instance_exists(self.id, "paint_start"){
  self.paint_start = true
  
  var paint_count = scr_queue_has_mod_count(active_queue, scr_mod_paint)
  
  if (paint_count >= 5){
    mod_paint_dist = point_distance(x, y, owner_id.x, owner_id.y)
  }else{
    mod_paint_dist = (point_distance(x, y, owner_id.x, owner_id.y) / ((5/paint_count/5) * room_speed))
//    show_debug_message("(5/paint_count/5) * room_speed) "+string((5/paint_count/5) * room_speed))
  }
//  show_debug_message("mod_paint_dist = "+string(mod_paint_dist))
} 



if self.paint_start {
}



self.timeout--

return returned

