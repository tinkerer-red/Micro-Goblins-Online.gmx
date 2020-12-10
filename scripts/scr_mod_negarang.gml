///scr_mod_negarang  (find a better name for this)
//
//pre collision modifier

//show_debug_message("scr_mod_negarang")

var returned = false


///define variables on first launch
if !variable_instance_exists(self.id, "negarang_start"){
  self.negarang_start = true
  
  var negarang_count = scr_queue_has_mod_count(active_queue, scr_mod_negarang)
  
  if (negarang_count >= 5){
    mod_nega_dist = point_distance(x, y, owner_id.x, owner_id.y)
  }else{
    mod_nega_dist = (point_distance(x, y, owner_id.x, owner_id.y) / ((5/negarang_count/5) * room_speed))
//    show_debug_message("(5/negarang_count/5) * room_speed) "+string((5/negarang_count/5) * room_speed))
  }
//  show_debug_message("mod_nega_dist = "+string(mod_nega_dist))
} 



if self.negarang_start {
  self.last_x = owner_id.x-lengthdir_x(mod_nega_dist,owner_id.dir)
  self.last_y = owner_id.y-lengthdir_y(mod_nega_dist,owner_id.dir)
  self.timeout = room_speed
  self.contact_owner = false
  
  ///set initial speeds
  //owner_id.player_state = e_player_state.attack
  speed = 0
  self.negarang_start = false
  owner_id.spd = mod_nega_dist
}



///if the player is stuck on a slope or in between solids
if point_distance(owner_id.x, owner_id.y, self.last_x, self.last_y) < 8/2
  { stopped = true }
else
  { stopped = false }



if (point_distance(owner_id.x, owner_id.y, self.x, self.y) < mod_nega_dist) //if about to collide
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
  owner_id.dir = direction
  owner_id.spd = mod_nega_dist
  
  last_x = owner_id.x
  last_y = owner_id.y
}



self.timeout--

return returned

