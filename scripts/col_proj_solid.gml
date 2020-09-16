///col_projectile_ground()

var returned = false

if !place_free(x,y) {
  self.pre_collide = true
  collide_solid = true
  
  returned = true
}

return returned;
