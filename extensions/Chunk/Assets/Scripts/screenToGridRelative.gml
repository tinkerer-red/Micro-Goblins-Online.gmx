///screenToGridRelative(x,y)
//relative, meaning, values
//are moduloed between 0 and 384

global.temp[2]=callChunk(argument[0],argument[1]); //we know chunkAtPos doesn't utilize temp2
global.temp[0]=modulo_euclidian(floor(((argument[0]-global.temp[2].x)/global.chunk_length)*global.cell_count),global.chunk_length);
global.temp[1]=modulo_euclidian(floor(((argument[1]-global.temp[2].y)/global.chunk_length)*global.cell_count),global.chunk_length);

