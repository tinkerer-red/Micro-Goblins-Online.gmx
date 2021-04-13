/// gml_task_progress_get(task_map)
/// Get the current progress of a task


	gml_pragma("forceinline");

	// Returns a percentage from 0 to 1
	return argument0[? GmlTasks.Scripts] / argument0[? GmlTasks.Script_Count];

