///gridAbsoluteToScreen(x,y)

global.temp[0]=argument[0]*global.cell_size;
global.temp[1]=argument[1]*global.cell_size;

global.temp[2]=callChunk(global.temp[0],global.temp[1]);
