///deal_damage_radius(radius, damage_amount, [no_iframe, damage_allies])

var radius = argument[0];
var damage_amount = argument[1]

//no_iframes
if (argument_count >= 3){
  var no_iframes = argument[2]
}else{
  var no_iframes = false
}

//damage_allies
if (argument_count = 4){
  var damage_allies = argument[3]
}else{
  var damage_allies = false
}

var list = collision_circle_list(x, y, radius, obj_entity, -1, true);

//if the returned list is filled with noone, then exit
if (list == noone) exit;


var list_length = ds_list_size(list)

for(var i = 0; i < list_length; i++){
  var entity = list[| i]
  
  if ((damage_allies) || (is_enemy(entity))){
    deal_damage(entity, damage_amount, no_iframes)
  }
}
