///anim_rotate()

/* This script is used to animate the sprite rotation mimicing
     the paper mario style with out the need for seperate arm
     or leg sprites
   
   Make sure to account for player direction as the sprite will
     rotate in different styles based on the direction it rotated
     to, for instance when the player walks right, then up, then
     left. the front side (right) of the sprite will shrink at 
     it rotates to give the illusion it is further away from the 
     camera.
     
   Returns: Bool (True when animation is finished, False for any other state)
*/

returned = false


if !variable_instance_exists(self.id, "anim_rotate_start") {anim_rotate_start = true}


//set the animation variables
if (anim_rotate_start)
{
  anim_time = floor(room_speed*0.25)
  anim_timer = anim_time
  anim_flip_frame = floor(anim_time*0.5)
  //anim_ideal_delta_time = 1/room_speed * 1000000; //typically 33333 or 16666
  anim_travel_dis = sprite_width/anim_time
  pi_time = pi / anim_time
  //this variable is used to keep track of the last view we did. 9 is a view which doesnt exist so it will think it's a new frame
  view_loop = 9
  
  //if turning prefered up  
  if (direction > 0) && (direction < 180) {anim_face_dir = -1}
  //if turning prefered down or instant turn
  if (direction = 0) || ((direction < 360) && (direction >= 180)) {anim_face_dir = 1}
  
  //if turning left
  if (direction > 90) && (direction < 270) {anim_rotate_dir = -1}
  //if turning right
  if (direction < 90) || (direction > 270) {anim_rotate_dir = 1}
  //anim_rotate_dir = sign(image_xscale)
  
  max_y_multiplier = abs(sprite_height)*0.2 //20 percent of the height
  
  anim_rotate_start = false
}

/// tris will multiply variables by 1 or -1 fepending on the flip
var flip_multiplier = sign(anim_timer - anim_flip_frame)


// the x distance the flip needs to travel, acounting delta time
//var trav_dis = anim_travel_dis * lag()

/// a negative number means we were right, and we're turning left
var trav_dis_x = cos(anim_timer * pi_time) * (sprite_width/2) - abs(sprite_width/2)*anim_rotate_dir

// how much we skew the y for either the front of back of the player
var y_miltiplier = cos((anim_timer-anim_flip_frame)  * pi_time)*max_y_multiplier


draw_sprite_pos(sprite_index,
                image_index, 
                
                //top left
                x-(sprite_xoffset)+trav_dis_x, 
                y-(sprite_yoffset)-(y_miltiplier*anim_face_dir), 
                
                //top right
                x+(sprite_width-sprite_xoffset)-trav_dis_x, 
                y-(sprite_yoffset)+(y_miltiplier*anim_face_dir), 
                
                //bottom right
                x+(sprite_width-sprite_xoffset)-trav_dis_x, 
                y+(sprite_height-sprite_yoffset)+(y_miltiplier*anim_face_dir), 
                
                //bottom left
                x-(sprite_xoffset)+trav_dis_x, 
                y+(sprite_height-sprite_yoffset)-(y_miltiplier*anim_face_dir), 
                
                image_alpha);


if (anim_timer <= 0)
{
  returned = true
  anim_rotate_start = true
  anim_face_dir = 0
  
  anim_time = 0
  anim_timer = 0
  anim_flip_frame = 0
  anim_travel_dis = 0
  pi_time = 0
  view_loop = 9
  max_y_multiplier = 0
  max_x_multiplier = 0
  anim_idle_start = 1
  anim_walk_start = 1
  anim_rotate_start = 1
  anim_damage_start = 1
}
//this will keep track of the view ports we've iterated through, that way we never count down the anim timer more then once each frame
if (view_current < view_loop) || (global.numberOfLocalPlayers = 1){
  view_loop = view_current
  anim_timer -= 1*lag()
}else if (view_current > view_loop){
  view_loop = view_current
}



return returned


