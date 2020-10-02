global.cell_size=24;
global.cell_count=16;
global.chunk_length=global.cell_size*global.cell_count;

//some temporary registers to set the output
//of some functions, etc. They're normally single-use.
global.temp[0]=-1;
global.temp[1]=-1;
global.temp[2]=-1;
global.temp[3]=-1;
global.temp[4]=-1;
global.temp[5]=-1;
global.temp[6]=-1;
global.temp[7]=-1;

global.save_location="save/"; //for now, it will do

//create some starter chunks
/*
for (var cx=-1; cx<=1; cx++)
for (var cy=-1; cy<=1; cy++)
    {
    callChunk(cx*global.chunk_length,cy*global.chunk_length);
    }



//you can also set the seed here, etc.
