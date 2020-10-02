///gridRelativeToScreenRelative(x,y,calling_chunk)

global.temp[0]=argument[0]*global.cell_size;
global.temp[1]=argument[1]*global.cell_size;
//since we didn't add x and y, chunkAtPos is currently only interested in absolute coords
global.temp[2]=callChunk(argument[2].x+global.temp[0],argument[2].y+global.temp[1]);
