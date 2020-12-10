///scr_mod_evade
//
//global
//post attack modifier


returned = false

//when finished
if (self.mod_evade_frame >= ceil(room_speed/15))
{
  if (scr_queue_has_mod_count(active_queue, scr_mod_evade) = 1){
    spd = 0
  }
  self.mod_evade_frame = 0
  
  returned = true
}


if (self.mod_evade_frame < ceil(room_speed/15))  && (returned = false){
  if point_distance(0,0, (right-left), (down-up)) != 0{
    var ideal_dir =  point_direction(0,0, (right-left), (down-up))
    var move_vector = add_vectors(1, ideal_dir, 32, dir)
    dir = move_vector[1]
  }
  
  spd =  -8*(60/room_speed)//move_vector[0]
  self.mod_evade_frame++
}


return returned


/*
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
