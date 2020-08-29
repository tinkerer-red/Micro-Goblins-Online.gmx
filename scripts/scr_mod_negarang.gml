///scr_mod_negarang  (find a better name for this)
//
//pre collision modifier

//show_debug_message("scr_mod_negarang")

var returned = false

///define variables on first launch
if !variable_instance_exists(self.id, "negarang_start"){
  self.negarang_start = true
}
if self.negarang_start {
  self.last_x = owner_id.x-lengthdir_x(8,owner_id.dir)
  self.last_y = owner_id.y-lengthdir_y(8,owner_id.dir)
  self.timeout = room_speed
  self.contact_owner = false
  
  ///set initial speeds
  //owner_id.player_state = e_player_state.attack
  speed = 0
  self.negarang_start = false
  owner_id.spd = 8

}



///if the player is stuck on a slope or in between solids
if point_distance(owner_id.x, owner_id.y, self.last_x, self.last_y) < 8/2
  { stopped = true }
else
  { stopped = false }



if (point_distance(owner_id.x, owner_id.y, self.x, self.y) < owner_id.spd) //if about to collide
|| (self.timeout <= 0) 
|| (owner_id.spd = 0) //if ran into a flat wall, used for ethereal shots
|| stopped  //if we're barely moveing / stuck
{
  owner_id.spd = 0
  if (self.timeout != 0) && (owner_id.spd != 0) {
    owner_id.x = self.x
    owner_id.y = self.y
  }
  returned = true
}



//this check is only here to make sure we dont add to speed after we have set it to 0
if !returned
{
  //make sure both direction variables are set to move towards the projectile
  owner_id.direction = point_direction(owner_id.x, owner_id.y, self.x, self.y)
  owner_id.dir = point_direction(owner_id.x, owner_id.y, self.x, self.y)
  owner_id.spd = 8
  
  last_x = owner_id.x
  last_y = owner_id.y
  
  ////if we're still rollin on, then might as well add in the rope or chain draw functions here
  
  draw_line_width(owner_id.x, owner_id.y, self.x, self.y,3)
  //
}



self.timeout--

return returned

