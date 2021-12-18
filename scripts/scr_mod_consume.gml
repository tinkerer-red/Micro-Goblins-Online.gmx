///scr_mod_consume
//
//global
//pre attack modifier




returned = false
var ideal_spd = -960/room_speed //this comes out to be about 16 pixels per frame at 60fps


var mod_count = scr_queue_has_mod_count(active_queue, scr_mod_evade)



if (self.mod_evade_frame < ceil(room_speed/15))  && (returned = false)
{
  /*
  if point_distance(0,0, (right-left), (down-up)) != 0{
    var ideal_dir =  point_direction(0,0, (right-left), (down-up))
    var move_vector = mean_vectors(1, ideal_dir, 32, dir)
    dir = move_vector[1]
  }
  */
  spd = ideal_spd//move_vector[0]
  self.mod_evade_frame++
  var xx = x+lengthdir_x(1, direction)
  var yy = y+lengthdir_y(1, direction)
  draw_particle_dashLines(x, y, xx, yy)
}

//init the animation
if (!variable_instance_exists(self, "mod_evade_start")) || (mod_evade_start = false){
  mod_evade_start = true
  var xx = x+lengthdir_x(1, direction)
  var yy = y+lengthdir_y(1, direction)
  draw_particle_dashDust(x, y, xx, yy)
  draw_particle_dashLines(x, y, xx, yy)
}

//when finished
if (self.mod_evade_frame >= ceil(room_speed/15))
{
  if (mod_count = 1){
    spd = 0
    mod_evade_start = false
  }
  self.mod_evade_frame = 0
  
  
  returned = true
}


return returned
