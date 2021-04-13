///col_proj_solid()

var returned = false

if (ticked_over()){
  //if sgs_place_meeting_c_s(global.solid_sgs_field, x, y, obj_solid) {
  if place_meeting(x, y, obj_solid)
  || chunk_tile_meeting_precise(x, y){
    self.pre_collide = true
    collide_solid = true
    
    returned = true
  }
}

return returned;
