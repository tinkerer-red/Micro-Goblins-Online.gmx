///is_visible()

//Used to check if visible on current view, use only in the draw event

//using this is statement is messy but more efficient then checking all sides then deciding, as the && statement will not check the next value if it fails
//also holding off on addition and larger numbers till last will save just a few extra micro seconds
if (event_type = ev_draw){
  if (view_visible[view_current] = true){
    if (bbox_right > view_xview[view_current])
    && (bbox_bottom > view_yview[view_current])
    && (bbox_top < view_yview[view_current]+view_hview[view_current])
    && (bbox_left < view_xview[view_current]+view_wview[view_current])
    {
      return true;
    }else{
      return false;
    }
  }
}else{//if not inside the draw event
  //fast guess if visible.
  var nearest_player = instance_nearest(x, y, obj_player)
  var dist = point_distance(x,y,nearest_player.x,nearest_player.y)
  if (nearest_player.player_id_local != -1){
    if (dist > fast_hype(view_wview[nearest_player.player_id_local], view_hview[nearest_player.player_id_local])) return false;
  }
  
  var i=0;
  repeat(8){
    if (view_visible[view_current] = true){
      if (bbox_right > view_xview[view_current])
      && (bbox_bottom > view_yview[view_current])
      && (bbox_top < view_yview[view_current]+view_hview[view_current])
      && (bbox_left < view_xview[view_current]+view_wview[view_current])
      {
        return true;
      }
    }
   i++
  }
  return false;
}


