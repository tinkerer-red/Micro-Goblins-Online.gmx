///deal_knockback(knockback_to_id, knockback_amount, knockback_angle, [ingore_iframes])

var knockbacked_id = argument[0];
var knockback_amount = argument[1];
var knockback_angle = argument[2];


//if the knockback should make it through i frames, this is typically used when dealing negative damge, which would heal a player,
// this will also not give the knockbacked entity iframes.
if (argument_count = 4){
  var ingore_iframes = argument[3]
}else{
  var ingore_iframes = false
}





//first find the angle difference
var diff = angle_difference(knockbacked_id.direction, knockback_angle)

//if the angle difference is less than 180, then the player is already moving in the direction we want to apply knockback
if (abs(diff) < 90){
  var array = add_vectors(knockbacked_id.spd, knockbacked_id.direction, knockback_amount, knockback_angle);
  
  knockbacked_id.spd = array[0]
  knockbacked_id.direction = array[1]
  
}else{  //otherwise the knockback should be applying -spd and inverting the knockback angle
  var array = add_vectors(knockbacked_id.spd, knockbacked_id.direction, knockback_amount, knockback_angle);
  
  knockbacked_id.spd = -array[0]
  knockbacked_id.direction = array[1] - 180
}

/*
if instance_exists(knockbacked_id){
  
  knockbacked_id.image_blend = c_blue
  
  if (knockbacked_id.object_index = obj_player){
    show_debug_player(knockbacked_id.player_id_local, "e_knockback = "+string(e_knockback))
  }
}
