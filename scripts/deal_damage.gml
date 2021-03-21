///deal_damage(damage_to_id, damage_amount)

var damaged_id = argument0;

if (damaged_id.invulnerable = false){
  
  damaged_id.e_health -= argument1
  damaged_id.invulnerable = true
  
  draw_particle_blood(damaged_id.x, damaged_id.y)
  
  
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


/*
if instance_exists(damaged_id){
  
  damaged_id.image_blend = c_blue
  
  if (damaged_id.object_index = obj_player){
    show_debug_player(damaged_id.player_id_local, "e_damage = "+string(e_damage))
  }
}
