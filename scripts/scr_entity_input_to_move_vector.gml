///scr_entity_input_to_move_vector()


///get the move vector
//
var move_dis = min(point_distance(0, 0, (right-left), (down-up)), 1) * acceleration * (60/room_speed);
move_dir = point_direction(0, 0, (right-left), (down-up));


var move_vector = add_vectors(move_dis, move_dir, spd, dir)

var sign_multiplier = sign(spd)

if (abs(spd) <= max_speed * (60/room_speed)) //|| (abs(angle_difference(dir, move_dir)) >= 45)
|| (abs(spd) >= sprite_width)
{
  if (sign_multiplier != 0){
    spd = move_vector[0] * sign_multiplier
  }else{
    spd = move_vector[0]
  }
}


if (sign_multiplier = 1){
  dir = move_vector[1]
}


