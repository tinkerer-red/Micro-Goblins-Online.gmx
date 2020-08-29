///scr_mod_boomerang
//
//pre collision modifier

//show_debug_message("scr_mod_boomerang")

var returned = false

if collide_ground && (self.do_not_collide = false)
{
  if (dis_traveled >= w_range)
  {
    forward = true
    backward = false
    default_speed = speed
    dis_traveled = 0
  }else{
    dis_traveled = 0
  }
  
  if backward
  {
    if speed < default_speed
    {
      speed = speed*2
    }else{
      speed = default_speed
      dis_traveled = 0
      backward = false
      forward  = false
      
      self.collide = false
      self.pre_collide = false
      
      do_not_collide = true
      
      returned = true
    }
    
  }
  
  if forward
  {
    if speed > 1
    {
      speed = speed/2
    }else{
      backward = true
      forward  = false
      direction =  direction + 180
      if (direction > 360) {direction -= 360}
    }
    
  }
  
}

//if returned = true
//{
//  ds_priority_delete_value(self.pre_col_queues, scr_mod_boomerang)
//}

return returned

