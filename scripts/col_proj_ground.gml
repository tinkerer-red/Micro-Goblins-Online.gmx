///col_proj_ground()

var returned = false

if (point_distance(x, y, owner_id.x, owner_id.y) > obj_chunk_supervisor.chunk_width*4){
  collision_active = false
  instance_destroy()
}

if (dis_traveled >= w_range)
  {
    self.pre_collide = true
    collide_ground = true
    returned = true
    
    if (collision_active)
    && instance_number(obj_weap_proj) < 150{
      draw_particle_dust(x, y)
    }
  }
  

return returned;
