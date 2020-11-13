///scr_mod_thrust

/* This script is used to animate the melee weapon for a thrust
     attack.
   
   Make sure to account for player direction as the sprite will
     rotate in different styles based on the direction it rotated
     to.
   
   Returns: Bool (True when animation is finished, False for any other state)
*/

returned = false


if !variable_instance_exists(self.id, "anim_thrust_start") {anim_thrust_start = true}


//set the animation variables
if (anim_thrust_start)
{
  // anim_time is used to equate exactly how many frames the animation needs to take
  anim_thrust_time = floor(room_speed*1)
  
  // anim_timer is used to equate where the sin/cos wave currently is
  anim_thrust_timer = anim_thrust_time
  
  pi_time = pi / anim_thrust_time
  
  // lastly max_-_multiplier is the maximum distance we want the axis to move, the cos/sin function would move it a parcent of the max
  anim_thrust_max_direction_multiplier = 180
  
  // this variable is only used to make sure we only calculate the animation's variables once
  anim_thrust_start = false
  
  max_dist_multiplier = dis
  max_dir_multiplier = 20
  
}


///notes to understand the cos and sin
// 
// cos((anim_timer-anim_flip_frame) * pi_time)
// sin((anim_timer) * pi_time)
// 
// anim_timer is used to equate where the wave currently is
// anim_flip_frame is used to move the wave over, of course if you want to move it over exactly by half then you can just use sin() instead of cos()
// pi_time is just a method to make the wave it's self. multiplying pi_time will dictate how many times to wave peaks/vallies before it finishes the timer
// lastly max_-_multiplier is the maximum distance we want the axis to move, the cos/sin function would move it a parcent of the max


/// a negative number means we were facing right, and we're turning left
var trav_dis_dist = cos((anim_thrust_timer) * pi_time*(60/6)) * (max_dist_multiplier*0.75);// + (max_dist_multiplier*0.75);
var trsv_dis_dir = cos((anim_thrust_timer) * pi_time*(80/6)) * max_dir_multiplier;

x += lengthdir_x(trav_dis_dist, direction+trsv_dis_dir);
y += lengthdir_y(trav_dis_dist, direction+trsv_dis_dir);

direction = point_direction(owner_id.x, owner_id.y, x, y)
image_angle = direction-45

if (anim_thrust_timer <= 0)
{
  returned = true
  anim_thrust_start = true
  
  anim_thrust_time = 0
  anim_thrust_timer = 0
  anim_thrust_max_direction_multiplier = 0
}

//increment timer
anim_thrust_timer -= 1*lag()

return returned


