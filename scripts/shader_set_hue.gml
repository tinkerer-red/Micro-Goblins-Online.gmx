/// shader_set_hue(hue) [0-255]

// hue = 0-255

// (hue/255)*(pi*2) when we reverse the formula, the arbitrary conversion number is 40.584...
var radians = argument0/40.584510488433310621065359659991
//(owner_id.fav_hue/256)*(6.28)
shader_set(shd_hue);
var u_position = shader_get_uniform(shd_hue, "u_Position");
shader_set_uniform_f(u_position, radians);

