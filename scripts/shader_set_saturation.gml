/// shader_set_saturation(sat) [-1 to 1]

// saturation = -1 - 1
shader_set(shd_saturation);
var pos_uni = shader_get_uniform(shd_saturation, "Position"); // control shader
shader_set_uniform_f(pos_uni, argument0);

