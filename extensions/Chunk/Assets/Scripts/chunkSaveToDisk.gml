///chunkSaveToDisk(chunk_obj)

//for now, we only have two things to save: the data and the gfx.
//naming convention:
/*
ch.0.9.unk.dat
ch.0.9.unk.gfx



*/

var chunkey=argument[0];
//get it's "coordinates"
var _x=chunkey.x/global.chunk_length;
var _y=chunkey.y/global.chunk_length;

var filename_common=global.save_location+"ch."+string(_x)+"."+string(_y)+".unk";
var filename_dat=filename_common+".dat";
var filename_gfx=filename_common+".gfx";

//data...
var file = file_text_open_write(filename_dat);

file_text_write_string(file,ds_grid_write(chunkey.tunnel_data));
file_text_close(file);

//and gfx
background_save(chunkey.tunnel_gfx,filename_gfx);
