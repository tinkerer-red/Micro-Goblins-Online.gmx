///scr_mod_cluster
//
//pre collision modifier

//show_debug_message("scr_mod_cluster")

var returned = false

//if !to_much_lag(){
  
  if (object_index = obj_weap_proj){
    if (self.do_not_collide = false){
      
      
      
      //remove the old cluster before we clone
      ds_priority_delete_value(self.pre_col_queues, scr_mod_cluster)
      ds_priority_delete_value(self.pre_col_queues_temp, scr_mod_cluster)
      
      
      //find outy if it's even worth the effort to create more projectiles, or if there are already to many in the area.
      //this part of the code is ONLY a last resort failsafe to prevent all spawning and stop the modifier, it should only be activated if there is way to much lag
      var count = instance_number(obj_weap_proj)
      if to_much_lag()
      || (fps < 10)
      //||  count > 800
      //|| (instance_number(obj_weap_proj) >= (2000/global.numberOfLocalPlayers))
      {
        collision_active = false;
        //instance_destroy()
        return true;
        exit;
      }
      
      
      //declare the new variables here before we clone the projectile
      collide_solid = false
      collide_ground = false
      collide_enemy = false
      
      self.collide = false
      self.pre_collide = false
      
      do_not_collide = true
      
      if variable_instance_exists(id, "clustered_count"){
        clustered_count += 1
      }else{
        clustered_count = 1
      }
      
      if (clustered_count >= 2){
        mask_index = -1
      }
      
      //////////////////////////Do cluster stuff here
      var repeated = ceil(2.25-0.25*clustered_count)
        repeat(repeated){ //ideally 3
          var proj = instance_copy(false);
          
          //this if statement is only here because durring a oneframe window,
          //if the projectile was destroyed, it will end up trying to call 'proj' when proj does not exist
          if instance_exists(proj){
          
            //create new queues
            proj.weapon_event_queues = ds_priority_create()
            ds_priority_copy(proj.weapon_event_queues, weapon_event_queues)
            
            proj.step_event_queues = ds_priority_create()
            ds_priority_copy(proj.step_event_queues, self.step_event_queues)
            //the step event will fill this priority for us
            proj.step_event_queues_temp = -1
            
            proj.pre_col_queues = ds_priority_create()
            ds_priority_copy(proj.pre_col_queues, self.pre_col_queues)
            proj.pre_col_queues_temp = -1
            
            
            //variables
            proj.direction = htme_random_range(0, 360)
            var r = htme_random_range(0.555, 0.777);
            proj.w_range = (w_range*r)//*0.666
            proj.dis_traveled = 0
            proj.speed = speed*0.7
            proj.image_angle = proj.direction-45
            proj.x = x+lengthdir_x(4,proj.direction)
            proj.y = y+lengthdir_y(4,proj.direction)
            proj.start_x = proj.x
            proj.start_y = proj.y
            
            //adjust paths for laser and other modifiers
            var path_number = path_get_number(previous_locations_path)-1;
            var path_xx = path_get_point_x(previous_locations_path, path_number);
            var path_yy = path_get_point_y(previous_locations_path, path_number);
            proj.previous_locations_path = path_add();
            path_set_closed(proj.previous_locations_path, false);
            path_add_point(proj.previous_locations_path, path_xx, path_yy, speed);
          }
      }
      // with self
      var proj = self.id;
      
      
      //this if statement is only here because durring a oneframe window,
      //if the projectile was destroyed, it will end up trying to call 'proj' when proj does not exist
      if instance_exists(proj){
        //variables
        proj.direction = htme_random_range(0, 360)
        var r = htme_random_range(0.555, 0.777);
        proj.w_range = (w_range*r)//*0.666
        proj.dis_traveled = 0
        proj.speed = speed*0.7
        proj.image_angle = proj.direction-45
        proj.x = x+lengthdir_x(4,proj.direction)
        proj.y = y+lengthdir_y(4,proj.direction)
        proj.start_x = proj.x
        proj.start_y = proj.y
        //////////////////////////    
      }
    }
    
  //  returned = true
  }
//}else{
//  return true;
//}

return returned

