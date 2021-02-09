///scr_mod_paint
//
//collision modifier

var returned = false


///define variables on first launch

var mod_count = scr_queue_has_mod_count(active_queue, scr_mod_paint)

if !variable_instance_exists(self, "mod_paint_start"){
  mod_paint_start = true
  paint_count = mod_count
}

//remove all but the last one
if (mod_count != 1){
  return true;
}


//make the color
var color = make_colour_hsv(htme_random(255), 255, 255);

//add the particle to the system
draw_particle_paint(prt_paint2, x, y, color, 16)
 

return true;

