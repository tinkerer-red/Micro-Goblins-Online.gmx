///mean_vectors(vect_1_dist, vect_1_dir, vect_2_dist, vect_2_dir)

//
// returns array
// [0] distance
// [1] direction

var v1_x = lengthdir_x(argument[0], argument[1]);
var v1_y = lengthdir_y(argument[0], argument[1]);

var v2_x = lengthdir_x(argument[2], argument[3]);
var v2_y = lengthdir_y(argument[2], argument[3]);

var final_v_x = mean(v1_x, v2_x);
var final_v_y = mean(v1_y, v2_y);

var final_vector_array;
final_vector_array[0] = point_distance(0,0,final_v_x,final_v_y)
final_vector_array[1] = point_direction(0,0,final_v_x,final_v_y)


return final_vector_array;



