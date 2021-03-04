///deal_damage(damage_to_id)

var damaged_id = argument0;

if instance_exists(damaged_id){
  
  damaged_id.image_blend = c_blue
  
  if (damaged_id.object_index = obj_player){
    show_debug_player(damaged_id.player_id_local, "e_damage = "+string(e_damage))
  }
}
