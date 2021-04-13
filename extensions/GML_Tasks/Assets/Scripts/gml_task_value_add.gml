/// gml_task_value_add(task_map,key_real,value)
/// Add value to task map, using a real as a key is recommended

	gml_pragma("forceinline");

	ds_map_add(argument0[? GmlTasks.Values],argument1,argument2);

