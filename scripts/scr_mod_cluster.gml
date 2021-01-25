///scr_mod_cluster
//
//pre collision modifier

//show_debug_message("scr_mod_cluster")

var returned = false

if (object_index = obj_weap_proj){
  if (self.do_not_collide = false){
    
    //remove the old cluster before we clone
    ds_priority_delete_value(self.pre_col_queues, scr_mod_cluster)
    ds_priority_delete_value(self.pre_col_queues_temp, scr_mod_cluster)
    
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
    
    if (clustered_count >= 3){
      mask_index = -1
    }
    
    //////////////////////////Do cluster stuff here
    var repeated = ceil(2.25-0.25*clustered_count)
      repeat(repeated){ //ideally 3
        var proj = instance_copy(false);
        
        //create new queues
        proj.weapon_event_queues = ds_priority_create()
        ds_priority_copy(proj.weapon_event_queues, self.weapon_event_queues)
        
        proj.step_event_queues = ds_priority_create()
        ds_priority_copy(proj.step_event_queues, self.step_event_queues)
        //the step event will fill this priority for us
        proj.step_event_queues_temp = -1
        
        proj.pre_col_queues = ds_priority_create()
        ds_priority_copy(proj.pre_col_queues, self.pre_col_queues)
        proj.pre_col_queues_temp = -1
        
        
        //variables
        proj.direction = htme_random_range(0, 360)
        proj.w_range = w_range*0.666
        proj.dis_traveled = 0
        proj.speed = speed*0.666
        proj.image_angle = proj.direction-45
        proj.x = x+lengthdir_x(2,proj.direction)
        proj.y = y+lengthdir_y(2,proj.direction)
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
    // with self
    var proj = self.id;
    //variables
    proj.direction = htme_random_range(0, 360)
    proj.w_range = w_range*0.666
    proj.dis_traveled = 0
    proj.speed = speed*0.666
    proj.image_angle = proj.direction-45
    proj.x = x+lengthdir_x(2,proj.direction)
    proj.y = y+lengthdir_y(2,proj.direction)
    proj.start_x = proj.x
    proj.start_y = proj.y
    //////////////////////////    
  }
  
//  returned = true
}

return returned

