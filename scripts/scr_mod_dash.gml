///scr_mod_dash
//
//global
//pre attack modifier



returned = false

//when finished
if (self.mod_dash_frame >= ceil(room_speed/15))
{
  if (scr_queue_has_mod_count(active_queue, scr_mod_dash) = 1){
    spd = 0
  }
  self.mod_dash_frame = 0
  
  returned = true
}


if (self.mod_dash_frame < ceil(room_speed/15))  && (returned = false)
{
  if point_distance(0,0, (right-left), (down-up)) != 0{
    var ideal_dir =  point_direction(0,0, (right-left), (down-up))
    var move_vector = add_vectors(1, ideal_dir, 32, dir)
    dir = move_vector[1]
  }
  
  spd = 8*(60/room_speed)//move_vector[0]
  self.mod_dash_frame++
}


return returned
