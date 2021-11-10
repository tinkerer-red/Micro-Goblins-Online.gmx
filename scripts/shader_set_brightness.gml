/// shader_set_brightness(sat) [-1 to 1]

// brightness = -1 - 1
shader_set(shd_brightness);
pos_uni= shader_get_uniform(shd_brightness, "Position"); // control shader
shader_set_uniform_f(pos_uni, argument0);

