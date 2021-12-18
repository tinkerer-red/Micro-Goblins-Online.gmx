///item_spawn(item_nbt, x, y[[, spd, dir], owner_id])

var item = argument[0];
var xx   = argument[1];
var yy   = argument[2];

if (argument_count > 3){
  var spd  = argument[3];
  var dir  = argument[4];
}else{
  var spd  = 0;
  var dir  = 0;
}

if (argument_count > 5){
  var owner = argument[5];
}else{
  var owner = noone;
}

//create the object in game
var obj = instance_create(xx, yy, obj_item);

//add the nbt data
if (ds_exists(item, ds_type_map)){
  obj.nbt = item
}

//apply the acceleration
obj.spd = spd
obj.direction = dir

//apply the owner
obj.item_owner = owner


