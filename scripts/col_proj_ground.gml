///col_proj_ground()

var returned = false

if (dis_traveled >= w_range)
  {
    self.pre_collide = true
    collide_ground = true
    returned = true
    draw_particle_dust(x, y)
  }
  

return returned;
