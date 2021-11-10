/// scr_cbDataGUI_folder_is_open(folder_instance);
/**
* @brief  Returns true if the folder is open and false if the folder is closed
*
* @param  {instance} folder_instance  Folder to be opened/closed
*
* @see scr_cbDataGUI_add_folder
*/

var obj  = argument0;

if (!instance_exists(obj)) return false;

return obj._isOpen;
