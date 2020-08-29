///scr_player_state_move_input(player_id_local, modifier)

var player_id_local = argument[0]
var modifier = argument[1]


///get the move vector
//
var move_dis = min(point_distance(0, 0, (right-left), (down-up)), 1) * acceleration;
var move_dir = point_direction(0, 0, (right-left), (down-up));

var move_vector = add_vectors(move_dis, move_dir, spd, dir)


if !(abs(spd) >= max_speed) || (abs(angle_difference(dir, move_dir)) >= 45)
{ spd = move_vector[0] }
dir = move_vector[1]


//this should be dynamic instead
//spd = clamp(spd, -max_speed, max_speed)
///


///apply friction if nothing is being pressed

