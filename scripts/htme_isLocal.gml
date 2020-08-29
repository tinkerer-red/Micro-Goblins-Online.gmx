///htme_isLocal();

/*
**  Description:
**      Returns if this instance was created locally or not
**      If it was not initialized with mp_sync, this will CRASH THE GAME!
**  
**  Usage:
**      <See above>
**
**  Arguments:
**      <none>
**
**  Returns:
**      true or false
**
*/

///Check to make sure the htme object even exists, otherwise obviously we will be forced to play locally.
if(variable_global_exists("htme_object"))
{

//When currently setting up this instance as a network instance, we are
//obviously not local.
if (global.htme_object.tmp_creatingNetworkInstance) return false;

/* Check was removed for performance reasons

//Make sure, we are in list
var go = false;
var key= ds_map_find_first(global.htme_object.globalInstances);
//This will loop through all global instances
for(var i=0; i<ds_map_size(global.htme_object.globalInstances); i+=1) {
    var inst_id = ds_map_find_value(global.htme_object.globalInstances,key);
    if (inst_id == self.id) go = true;
    key = ds_map_find_next(global.htme_object.globalInstances, key);
}
if (go)

*/
    if (variable_instance_exists(self, "htme_mp_player")) && (variable_global_exists("htme_object"))
    {
      return self.htme_mp_player == global.htme_object.playerhash;
    } else {
      return true
    }
}else{
return true
}
//else return false;
