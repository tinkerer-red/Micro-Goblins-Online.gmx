///chunkAtPos(screen_x,screen_y)
//
global.temp[0]=floor(argument[0]/global.chunk_length)*global.chunk_length;
global.temp[1]=floor(argument[1]/global.chunk_length)*global.chunk_length;

return instance_position(global.temp[0],global.temp[1],objChunk);
