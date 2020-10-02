///gridRelativeToScreenAbsolute(x,y,calling_chunk)

global.temp[3]=argument[2].x+(argument[0]*global.cell_size);
global.temp[4]=argument[2].y+(argument[1]*global.cell_size);

global.temp[5]=callChunk(global.temp[3],global.temp[4]);
