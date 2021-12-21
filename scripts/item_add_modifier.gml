///item_add_modifier(item, modifier_script_id)

var item = argument0;

if is_string(argument1){
  var mod_script = asset_get_index(argument1);
}else{
  var mod_script = argument1;
}

if ds_map_exists(item, "modifiers_string"){
  var modifiers_string = item[? "modifiers_string"];
}else{
  ///right here we should really just run a script to generate the modifier's strings because maybe
  //  the user fucked up the save file.
  item[? "modifiers_string"] = ""
  var modifiers_string = item[? "modifiers_string"];
}



modifiers_string += ",";

switch mod_script{
            //Global
  case scr_mod_aoe: modifiers_string += "AOE"; break;
  case scr_mod_continuous: modifiers_string += "Continuous"; break;
  case scr_mod_charged: modifiers_string += "Charged"; break;
  case scr_mod_repeater: modifiers_string += "Repeater"; break;
  case scr_mod_dash: modifiers_string += "Dash"; break;
  case scr_mod_evade: modifiers_string += "Evade"; break;
  case scr_mod_enlarge: modifiers_string += "Enlarge"; break;
  case scr_mod_shrink: modifiers_string += "Shrink"; break;
  case scr_mod_aimBot: modifiers_string += "Aim Bot"; break;
  case scr_mod_knockback: modifiers_string += "Knockback"; break;
            //Melee
  case scr_mod_slash: modifiers_string += "Slash"; break;
  case scr_mod_thrust: modifiers_string += "Thrust"; break;
  case scr_mod_chained: modifiers_string += "Chained"; break;
  case scr_mod_range: modifiers_string += "Ranged"; break;
  case scr_mod_swiftness: modifiers_string += "Swiftness"; break;
  case scr_mod_slowness: modifiers_string += "Slowness"; break;
  case scr_mod_backStab: modifiers_string += "Bakc Stab"; break;
  case scr_mod_flail: modifiers_string += "Flail"; break;
  case scr_mod_moveable: modifiers_string += "Moveable"; break;
  case scr_mod_extend: modifiers_string += "Extend"; break;
            //Ranged
  case scr_mod_sticky: modifiers_string += "Sticky"; break;
  case scr_mod_bonusShot: modifiers_string += "Bonus Shot"; break;
  case scr_mod_mirrorShot: modifiers_string += "Mirror Shot"; break;
  case scr_mod_multishot: modifiers_string += "Multi-Shot"; break;
  case scr_mod_inaccurate: modifiers_string += "Inaccurate"; break;
  case scr_mod_burst: modifiers_string += "Burst"; break;
  case scr_mod_cluster: modifiers_string += "Cluster"; break;
  case scr_mod_boomerang: modifiers_string += "Boomerang"; break;
  case scr_mod_negarang: modifiers_string += "Grapple"; break;
  case scr_mod_ricochet: modifiers_string += "Ricochet"; break;
  case scr_mod_seeking: modifiers_string += "Seeking"; break;
  case scr_mod_guiding: modifiers_string += "Guiding"; break;
  case scr_mod_laser: modifiers_string += "Laser"; break;
  case scr_mod_targeting: modifiers_string += "Targeting"; break;
  case scr_mod_airStrike: modifiers_string += "Air Strike"; break;
  case scr_mod_arcLightning: modifiers_string += "Arc Lightning"; break;
  case scr_mod_quickScope: modifiers_string += "Quick Scope"; break;
            //Summon
            //movement
  case scr_mod_summon_movement_walk: modifiers_string += "Summon Walk"; break;
  case scr_mod_summon_movement_orbital: modifiers_string += "Summon Orbital"; break;
  case scr_mod_summon_movement_chained: modifiers_string += "Summon Chained"; break;
  case scr_mod_summon_movement_jumpy: modifiers_string += "Summon Jumpy"; break;
              //Attack
  case scr_mod_summon_attack_leap: modifiers_string += "Summon Leap"; break;
  case scr_mod_summon_attack_stomp: modifiers_string += "Summon Stomp"; break;
  case scr_mod_summon_attack_hasten: modifiers_string += "Summon Hasten"; break;
  case scr_mod_summon_attack_kamikaze: modifiers_string += "Summon Kamikaze"; break;
              //Health
  case scr_mod_summon_health_default: modifiers_string += "Summon Health"; break;
  case scr_mod_summon_health_stout: modifiers_string += "Summon Stout"; break;
  case scr_mod_summon_health_enlarged: modifiers_string += "Summon Enlarge"; break;
  case scr_mod_summon_health_timed: modifiers_string += "Summon Timed"; break;
  case scr_mod_summon_health_multiply: modifiers_string += "Summon Multiply"; break;
              //Passive
  case scr_mod_summon_passive_mount: modifiers_string += "Summon Mount"; break;
            //Toy Mods
  case scr_mod_paint: modifiers_string += "Paint"; break;
              
  default: modifiers_string += "!~~~!ERROR!~~~!"; break;
}


//now actually apply the new string to the item
item[? "modifiers_string"] = modifiers_string

//now add the mod to the modifiers map
var mod_map = item[? "modifiers"]
if ds_map_exists(mod_map, mod_script){
  mod_map[? mod_script] += 1;
}else{
  mod_map[? mod_script] = 1;
}


obj_menu.update_menus = true






