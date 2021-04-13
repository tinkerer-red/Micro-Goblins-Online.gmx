/// gml_task_cleanup_script(task_map, script)
/// Assigns cleanup script to task

gml_pragma("forceinline");

	if ( ds_map_exists(argument0,GmlTasks.Cleanup_Script) ) {
		ds_map_add(argument0,GmlTasks.Cleanup_Script,argument1);
	} else {
		argument0[? GmlTasks.Cleanup_Script] = argument1;
	}
