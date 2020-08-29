///scr_mod_evade
//
//global
//post attack modifier



returned = false

if (self.mod_evade_frame >= ceil(room_speed/15))
{
  spd = 0
  self.mod_evade_frame = 0
  
  returned = true
}

if (self.mod_evade_frame < ceil(room_speed/15))  && (returned = false)
{
  spd = -8
  self.mod_evade_frame++
}


return returned
