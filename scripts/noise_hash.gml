///noise_hash(xPrimed, yPrimed)
var h;
h = global.chunk_handler.world_seed ^ argument0 ^ argument1;
//h *= $27d4eb2d;
return h;
