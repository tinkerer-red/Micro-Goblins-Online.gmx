///shader_set_clipped(x1, y1, x2, y2)
//set shader, call once
shader_set(shd_clipregion);
//define clip region, call whenever you need to set the clipping region
shader_set_uniform_f(shd_clipregion, argument0, argument1, argument2, argument3);

