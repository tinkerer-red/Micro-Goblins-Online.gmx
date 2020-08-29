///scr_player_state_move(player_id_local, modifiers)

var player_id_local = argument[0]
var modifier = argument[1]

if (spd != 0)
{
  if place_free(x, y)
  {
    var xx = x+lengthdir_x(spd, dir)
    var yy = y+lengthdir_y(spd, dir)
    
    if place_free(xx, yy)
    {
      x = xx
      y = yy
      direction = dir
      //show_debug_player(player_id_local, "spd = "+string(spd))
    }
    else
    {  
      if (abs(angle_difference(dir mod 45, 0)) < 12)
      {
        for (var dis = spd; dis > 0; dis--)
        {
          var xx = x+lengthdir_x(dis, dir)
          var yy = y+lengthdir_y(dis, dir)
          
          if (place_free(xx, yy))
          {
            x=xx
            y=yy
            spd -= dis
            break;
          }
        }
      }
      
      //flat wall check
      var x1 = lengthdir_x(1.75, dir+75)
      var y1 = lengthdir_y(1.75, dir+75)
      var x2 = lengthdir_x(1.75, dir-75)
      var y2 = lengthdir_y(1.75, dir-75)
      
      if !place_free(x+x1, y+y1) && !place_free(x+x2, y+y2)
      {
        //sprite_index = spr_red
        spd = 0
        //dir = point_direction(0, 0, (right-left), (down-up))
        direction = dir
        exit;
      }
      
      
      //this is used to help iterate each possible angle, so check left 10 degrees, then check right 10 degrees
      var collision_angle_precision = 10
      
      for (var angle = 9; angle <= 100; angle += collision_angle_precision)
      {
        for (var multiplier = -1; multiplier <= 1; multiplier += 2) //this is just a more efficient way to swap from left and right checks
        {
          var angle_to_check = dir + angle * multiplier
          
          //here we calculate speed relative to angle difference, so the player will slow down a bit on slopes
          //this only returns a multiplier, not the new speed
          var speed_multiplier = 0.5*abs(dcos(angle_difference(angle_to_check, dir))) + 0.5 //the 0.0 was 0.2, if the slope feels a bit to rough you can increase all slope speeds with this, or relative speeds with 0.8
          
          var xx = x+lengthdir_x(spd*speed_multiplier, angle_to_check)
          var yy = y+lengthdir_y(spd*speed_multiplier, angle_to_check)
          //show_debug_message("angle_to_check = "+string(angle_to_check))
          if place_free(xx, yy)
          {
            //hspeed = lengthdir_x(spd*speed_multiplier, angle_to_check)
            //vspeed = lengthdir_y(spd*speed_multiplier, angle_to_check)
            //speed = 0
            //show_debug_player(player_id_local, "spd = "+string(spd*speed_multiplier))
            x = x+lengthdir_x(spd*speed_multiplier, angle_to_check)
            y = y+lengthdir_y(spd*speed_multiplier, angle_to_check)
            
            if (object_index = obj_player)
            {
              if (self.player_state = e_player_state.move)
              {
                direction = angle_to_check
              }
            }
            exit;
          }
        }
        if (angle >= 80) var collision_angle_precision = 5;
      }
      
      //if no possible exit was found, this code will get ran.
      /*
      if (xprevious = x) || (yprevious = y)
      {
      
      }
      */
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





