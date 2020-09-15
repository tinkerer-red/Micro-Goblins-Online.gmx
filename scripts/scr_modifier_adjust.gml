///scr_modifier_adjust(queue, script, priority, count)

var queue = argument0;
var scr = argument1;
var prio = argument2;
var count = argument3;

var diff = count - scr_queue_has_mod_count(queue, scr)

if sign(diff) = 1 {
  repeat diff{
    ds_priority_add(queue,scr,prio)
  }
}else{
  repeat abs(diff){
    ds_priority_delete_value(queue,scr)
  }
}




