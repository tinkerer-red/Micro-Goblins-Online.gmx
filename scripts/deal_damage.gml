///deal_damage(damage_to_id, damage_amount, [no_iframe])

var damaged_id = argument[0];

if (argument_count = 3){
  var no_iframes = argument[2]
}else{
  var no_iframes = false
}

if (damaged_id.invulnerable = false) || (!no_iframes){
  
  damaged_id.e_health -= argument[1]
  draw_particle_blood(damaged_id.x, damaged_id.y)
  
  if not (no_iframes){
    damaged_id.invulnerable = true
    
    if (damaged_id.object_index = obj_enemy){
      damaged_id.iframes = room_speed*0.5
    }
    
    if (damaged_id.object_index = obj_summon){
      damaged_id.iframes = room_speed
    }
    
    if (damaged_id.object_index = obj_player){
      damaged_id.iframes = room_speed*2
    }
  }
  
}


/*
if instance_exists(damaged_id){
  
  damaged_id.image_blend = c_blue
  
  if (damaged_id.object_index = obj_player){
    show_debug_player(damaged_id.player_id_local, "e_damage = "+string(e_damage))
  }
}
