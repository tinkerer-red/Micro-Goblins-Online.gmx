///is_visible()

//Used to check if visible on current view, use only in the draw event

if (view_visible[view_current] = true){
  if rectangle_in_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom,
                            view_xview[view_current],
                            view_yview[view_current],
                            view_xview[view_current]+view_wview[view_current],
                            view_yview[view_current]+view_hview[view_current]) >= 1
  {
    return true;
  }else{
    return false;
  }
}



