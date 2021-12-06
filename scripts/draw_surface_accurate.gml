///draw_surface_accurate(id, x, y, xscale,yscale)

var _id = argument0,
    _x = argument1,
    _y = argument2,
    _xscale = argument3,
    _yscale = argument4,
    
    width = surface_get_width(_id),
    height = surface_get_height(_id);
    
  var tex = surface_get_texture(_id);
  
  draw_primitive_begin_texture(pr_trianglestrip, tex);
  
  draw_vertex_texture(_x, _y+height*_yscale-1, 0, 1);
  draw_vertex_texture(_x, _y, 0, 0);
  draw_vertex_texture(_x+width*_xscale-1, _y+height*_yscale-1, 1, 1);
  draw_vertex_texture(_x+width*_xscale-1, _y, 1, 0);
  draw_primitive_end();
  
