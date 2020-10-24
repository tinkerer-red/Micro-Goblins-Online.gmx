///time_script(script_id)

var timeStart = get_timer();

returned = script_execute(argument0)

var timeEnd = get_timer();
var time= timeEnd - timeStart;
show_debug_message(time)

return returned
