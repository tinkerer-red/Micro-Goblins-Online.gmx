/// draw_sprite_repeat(sprite, index, x, y, width, height, uv_scale[1]);

var sprite_to_draw = argument0;
var sprite_sub_index = argument1;
var x_pos = argument2;
var y_pos = argument3;
var width = argument4;
var height = argument5;
var uv_scale = argument6;

var tex = sprite_get_texture(sprite_to_draw, sprite_sub_index);
var tex_w = texture_get_texel_width(tex);
var tex_h = texture_get_texel_height(tex);

//NOTE: Change this to gpu_set_texrepeat if GM2
//texture_set_repeat(true); //This will set the texture mode to tile instead of wrap

draw_primitive_begin_texture(pr_trianglestrip, tex);
    draw_vertex_texture(x_pos, y_pos+height, 0, height*tex_h*uv_scale);
    draw_vertex_texture(x_pos, y_pos, 0, 0);
    draw_vertex_texture(x_pos+width, y_pos+height, width*tex_w*uv_scale, height*tex_h*uv_scale);
    draw_vertex_texture(x_pos+width, y_pos, width*tex_w*uv_scale, 0);
draw_primitive_end();
