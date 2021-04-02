///deal_tick_damage(target, damage, time, source_of_damage)

var target = argument0;
var damage = argument1;
var time   = argument2;
var source = argument3;

if is_entity(target){
  
  var key = "("+string(source)+","+string(id)+")"
  var map = target.damage_sources_map
  
  //if the map already exists update the stats
  if ds_map_exists(map, key){
    if (map[? "damage"] < damage){
      map[? "damage"] = damage
      map[? "time"] = time
      
    }else{
      if (map[? "damage"] = damage){
        map[? "time"] = max( time, map[? "time"] )
        
      }
    }
  }
  else
  {
    var damage_source = ds_map_create();
    
    damage_source[? "damage"] = damage
    damage_source[? "time"] = time
    damage_source[? "damage_dealer"] = source
    
    ds_map_add_map(target.damage_sources_map, key, damage_source)
  }
}



