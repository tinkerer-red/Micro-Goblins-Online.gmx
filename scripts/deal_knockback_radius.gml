///deal_knockback_radius(radius, knockback_amount, [knockback_allies])

var radius = argument[0];
var knockback_amount = argument[1]


//knockback_allies
if (argument_count = 3){
  var knockback_allies = argument[2]
}else{
  var knockback_allies = false
}


var list = collision_circle_list(x, y, radius, obj_entity, -1, true);
var list_length = ds_list_size(list)


for(var i = 0; i < list_length; i++){
  var entity = list[| i]
  
  if ((knockback_allies) || (is_enemy(entity))){
    var dir = point_direction(x, y, entity.x, entity.y)
    var dist = point_distance(x, y, entity.x, entity.y)
    
    //we normalize the distance so we dont fully knockback enemies which are barely in bounds of the radius
    var normalized_dist = 0.25 + (1-normalize(dist, 0, radius))*0.75
    
    //we then use the normalized distance to multiply the total knockback amount
    deal_knockback(entity, knockback_amount*normalized_dist, dir)
  }
}
