/// scr_mod_cluster

returned = false

//if !variable_instance_exists(id, "dis_traveled"){
//  dis_traveled = 0
//}

//show_debug_message("scr_mod_cluster")

if (object_index = obj_weap_proj){
  if dis_traveled >= floor(w_range/3){
    alarm_set(0, 1)
    returned = true
  }
}

/*
if !variable_instance_exists(self.id, "mod_cluster_init"){
  mod_cluster_init = true
  alarm_set(0, sec_to_frames(0.2))
}else{
  if mod_cluster_init = false{
    alarm_set(0, sec_to_frames(0.2))
  }
}
*/


return returned
