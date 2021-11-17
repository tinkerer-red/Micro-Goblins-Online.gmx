///jenkins_hash()
var PHI = 1.61803//3988749895
var hash = (argument0+argument1*11111)+global.chunk_handler.world_seed;
//hash += (hash << 10);
//hash ^= (hash >> 6);
//hash += (hash << 3);
//hash ^= (hash >> 11);
//hash += (hash << 15);
//hash += global.chunk_handler.world_seed;
if (frac(hash*argument0*PHI) >= 1){
show_debug_message(frac(hash*argument0*PHI))
}
return frac(hash*argument0*PHI);

return hash;

