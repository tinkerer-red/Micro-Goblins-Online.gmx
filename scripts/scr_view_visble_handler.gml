///scr_view_visble_handler()
if !variable_instance_exists(self, "visible_default")
{
  visible_default = visible
}

surface_set_target(view_surface_id[player_id_local])
//draw_text(0,0+18*5,"visible_default = "+string(visible_default))
surface_reset_target()

if (visible_default = true)
{
  var vis = false
  for (var i = 0; i < global.numberOfLocalPlayers; i++)
  {
    if (view_visible[i] - true)
    {
      if rectangle_in_rectangle(bbox_left,
                                bbox_top,
                                bbox_right,
                                bbox_bottom,
                                view_xview[i],
                                view_yview[i],
                                view_xview[i]+view_wview[i],
                                view_yview[i]+view_hview[i]) >= 1
      {
        var vis = true
      }
    }
  
  }
  visible = vis
}else{
visible = false
}



