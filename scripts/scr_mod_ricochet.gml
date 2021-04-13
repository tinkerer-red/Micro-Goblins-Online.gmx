///scr_mod_ricochet
//
//pre collision modifier

//show_debug_message("scr_mod_boomerang")

var returned = false

  
  if collide_solid && (self.do_not_collide = false)
  {
    var hype = fast_hype(sprite_height, sprite_width)
    var xx = x+lengthdir_x(hype/2,direction)
    var yy = y+lengthdir_y(hype/2,direction)
    
    var _dist = 0
    while !place_free(x,y){
      if (_dist > speed) break;
      x = x+lengthdir_x(-sign(speed),direction)
      y = y+lengthdir_y(-sign(speed),direction)
      //keep track of the distance backwards to make sure we dont move backwards all the way through another wall
      _dist++
    }
    
    //when we're no longer in the wall do the actual ricochet
    
    var norm_dir = collision_normal(xx,yy,obj_solid,hype*0.6,4);
    
    // this will find the angle difference then double it for the 
    direction = (direction-180)+angle_difference(norm_dir, direction-180)*2
    image_angle = direction-45
    // then we move the projectile to the new direction to make up for the lack of distance moved
    x = x+lengthdir_x(_dist,direction)
    y = y+lengthdir_y(_dist,direction)
    
    collide_solid = false
    
    self.collide = false
    self.pre_collide = false
    
    do_not_collide = true
    
    returned = true
  }
  
  //if returned = true
  //{
  //  ds_priority_delete_value(self.pre_col_queues, scr_mod_boomerang)
  //}

return returned

