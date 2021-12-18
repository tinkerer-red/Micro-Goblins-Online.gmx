///scr_player_state_move()

var time_adjust = 60/room_speed;

if (is_jocky){
  spd = 0
}

if (spd != 0)
{
  ///apply friction
  if (!ceil(right) && !ceil(left) && !ceil(down) && !ceil(up))
  || (right == left && up == down)
  || (abs(spd) > min(point_distance(0, 0, (right-left), (down-up)), 1) * max_speed * (time_adjust))
  || (sign(spd) = -1 || (abs(angle_difference(dir, move_dir)) >= 45))
  || (self.player_state != e_player_state.move)
  {
    var spd_multiplier = sign(spd);
    var desired_spd = abs(spd);
    
    spd -= acceleration * spd_multiplier * (time_adjust) * lag()
    
    var spd_multiplier_new  = sign(spd);
    
    //if we are close enough to the max speed and got dropped under it, then bring speed to equal it.
    //do this for both negative speed and possitive speed
    if (desired_spd > max_speed * time_adjust)
    && (abs(spd) < max_speed * (time_adjust))
    {
      spd = (max_speed * time_adjust) * spd_multiplier
    }
    
    //if we have crossed over 0, set spd to 0
    if (spd_multiplier_new != spd_multiplier)
      && (spd_multiplier_new != 0)
      && (spd_multiplier != 0)
    {
      show_debug_player(0, 'wut')
      spd = 0
    }
    
    //if no buttons are being pressed set the aim to the last moved direction
    if (!ceil(right) && !ceil(left) && !ceil(down) && !ceil(up))
    {
      dir = direction
    }else{
      if (abs(angle_difference(dir, move_dir)) >= 90){
        dir = move_dir
      }
    }
  }
  
  //show_debug_message("about to check for tile collisions")
  if place_free(x, y) && !chunk_tile_meeting_precise(x, y)
  {
    var xx = x+lengthdir_x(spd*lag(), dir)
    var yy = y+lengthdir_y(spd*lag(), dir)
    
    //add speed
    if place_free(xx, yy) && !chunk_tile_meeting_precise(xx, yy)
    {
      x = xx
      y = yy
      var spd_multiplier = sign(spd);
      if (spd_multiplier = 1){
        direction = dir
      }else{
        if (spd_multiplier = -1){
          direction = dir
        }
      }
      
      
      ///check to see if we collided with a interior cell structure
      if !(is_interior(x, y)){ //if we're outside
        if !chunk_tile_free(x, y, "layer_structures"){ //if we're collided with a structure
            //activate structure activate script
            //var _struct = chunk_tile_find(x, y, "layer_structures")
            
            //this script will find the structure type aswell as all other needed data
            chunk_interior_create(x, y)
        }
      }
      
      
    }
    else  //if we have collided with something
    {  
      //var last_x = x
      //var last_y = y
      move_towards(xx, yy, spd)
      
    }
  }else{ //if self's place not free
    
    //add the check for being stuck
    /*
    if (xprevious != x) || (yprevious != y)
    {
      //you managed to move inside a solid
      var out_dir = direction-180//point_direction(x, y, xprevious, yprevious)
      move_outside_solid(out_dir, speed)
      
    } else {
      //you werent moving when you became stuck
      
    }
    */
  }
}
//else {sprite_index = spr_green}





