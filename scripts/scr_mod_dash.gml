///scr_mod_dash
//
//global
//pre attack modifier




returned = false
var ideal_spd = 8*(60/room_speed)

var mod_count = scr_queue_has_mod_count(active_queue, scr_mod_dash)



if (self.mod_dash_frame < ceil(room_speed/15))  && (returned = false)
{
  /*
  if point_distance(0,0, (right-left), (down-up)) != 0{
    var ideal_dir =  point_direction(0,0, (right-left), (down-up))
    var move_vector = mean_vectors(1, ideal_dir, 32, dir)
    dir = move_vector[1]
  }
  */
  spd = ideal_spd//move_vector[0]
  self.mod_dash_frame++
}

//init the animation
if (!variable_instance_exists(self, "mod_dash_start")) || (mod_dash_start = false){
  mod_dash_start = true
  var xx = x+lengthdir_x(1, direction)
  var yy = y+lengthdir_y(1, direction)
  draw_particle_dashDust(x, y, xx, yy)
}

//when finished
if (self.mod_dash_frame >= ceil(room_speed/15))
{
  if (mod_count = 1){
    spd = 0
    mod_dash_start = false
  }
  self.mod_dash_frame = 0
  
  
  returned = true
}


return returned
