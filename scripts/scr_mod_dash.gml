///scr_mod_dash
//
//global
//pre attack modifier



returned = false

if (self.mod_dash_frame >= ceil(room_speed/15))
{
  spd = 0
  self.mod_dash_frame = 0
  
  returned = true
}

if (self.mod_dash_frame < ceil(room_speed/15))  && (returned = false)
{
  //var move_vector = mean_vectors(8, direction, spd, dir)

  spd = 8//move_vector[0]
  //dir = move_vector[1]
  self.mod_dash_frame++
}


return returned
