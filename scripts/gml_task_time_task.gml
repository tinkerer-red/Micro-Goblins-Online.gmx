/// gml_task_time_task(task_map)
/// Get percentage of frame time used out of our minimum task fps

	gml_pragma("forceinline");

	// Should be called inside of task scripts

	return (get_timer() - global.gml_task_timer_beginning) / (1000000 / argument0[? GmlTasks.Fps_Min]);



