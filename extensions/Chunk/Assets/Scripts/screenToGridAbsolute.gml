///screenToGridAbsolute(x,y)
//absolute, meaning, it will return
//cell coordinate within grid not limited to
//values between 0,384

global.temp[2]=callChunk(argument[0],argument[1]);
global.temp[0]=floor(((argument[0]-global.temp[2].x)/global.chunk_length)*global.cell_count);
global.temp[1]=floor(((argument[1]-global.temp[2].y)/global.chunk_length)*global.cell_count);

