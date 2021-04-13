/// gml_task_cleanup()
/// Clean up the gml task system

	ds_map_destroy(global.gml_task_map);
	ds_list_destroy(global.gml_task_list);

	global.gml_task_map = -1;
	global.gml_task_list = -1;

