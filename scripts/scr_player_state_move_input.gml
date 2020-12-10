///scr_player_state_move_input(player_id_local, modifier)

var player_id_local = argument[0]
var modifier = argument[1]


///get the move vector
//
var move_dis = min(point_distance(0, 0, (right-left), (down-up)), 1) * acceleration * (60/room_speed);
move_dir = point_direction(0, 0, (right-left), (down-up));

var move_vector = add_vectors(move_dis, move_dir, spd, dir)

var sign_multiplier = sign(spd)

if !(abs(spd) >= max_speed * (60/room_speed)) //|| (abs(angle_difference(dir, move_dir)) >= 45)
{
  if (sign_multiplier != 0){
    spd = move_vector[0] * sign_multiplier
  }else{
    spd = move_vector[0]
  }
}

//show_debug_message("scr_player_state_move_input POST spd === "+string(spd))

dir = move_vector[1] //+ (180 + (180 * sign_multiplier))



