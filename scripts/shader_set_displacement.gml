///shader_set_displacement(displacement_sprite)

texture_set_interpolation(true)
texture_set_repeat(true)

var displacement_sampler = shader_get_sampler_index(shd_water, "displacementMap")
var spr = sprite_get_texture(shd_water_displacement, 0);
shader_set(shd_water)
texture_set_stage(displacement_sampler, spr)
texture_set_interpolation_ext(displacement_sampler, true)
var time_uniform = shader_get_uniform(shd_water, "time")
shader_set_uniform_f(time_uniform, current_time / 1000)
var zoom_uniform = shader_get_uniform(shd_water, "zoom")
shader_set_uniform_f(zoom_uniform, obj_camera_control.player_zoom[view_current])


