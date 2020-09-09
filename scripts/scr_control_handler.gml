//scr_control_handler(player_id_local)

var pid = argument[0]


self.up    = obj_controller.up[pid]
self.down  = obj_controller.down[pid]
self.left  = obj_controller.left[pid]
self.right = obj_controller.right[pid]


if (gamepad_is_connected(pid)){
  if (obj_controller.lv_axis[pid] < -0.1) && ( up = 0)
    {self.up    = abs(obj_controller.lv_axis[pid])}
  if (obj_controller.lv_axis[pid] > 0.1) && ( down = 0)
    {self.down  = abs(obj_controller.lv_axis[pid])}
  if (obj_controller.lh_axis[pid] < -0.1) && ( left = 0)
    {self.left  = abs(obj_controller.lh_axis[pid])}
  if (obj_controller.lh_axis[pid] > 0.1) && ( right = 0)
    {self.right = abs(obj_controller.lh_axis[pid])}
}
  
  
  //action
  self.action          = obj_controller.action[pid]
  self.action_pressed  = obj_controller.action_pressed[pid]
  self.action_held     = obj_controller.action_held[pid]
  
  //item_a
  self.item_a          = obj_controller.item_a[pid]
  self.item_a_pressed  = obj_controller.item_a_pressed[pid]
  self.item_a_held     = obj_controller.item_a_held[pid]
  
  //item_b
  self.item_b          = obj_controller.item_b[pid]
  self.item_b_pressed  = obj_controller.item_b_pressed[pid]
  self.item_b_held     = obj_controller.item_b_held[pid]
  
  //item_c
  self.item_c          = obj_controller.item_c[pid]
  self.item_c_pressed  = obj_controller.item_c_pressed[pid]
  self.item_c_held     = obj_controller.item_c_held[pid]
  
  
  
  
