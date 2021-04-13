/// gml_task_time_system()
/// Get percentage of frame time used out of our minimum system fps

gml_pragma("forceinline");

// Should be called inside of task scripts

global.gml_task_timer = (get_timer() - global.gml_task_timer_beginning) / global.gml_task_framerate_time;
return global.gml_task_timer;


