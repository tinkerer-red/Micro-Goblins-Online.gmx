///chunkLoadFromDisk(chunk_screen_x,chunk_screen_y)


var _x=argument[0];
var _y=argument[1];

var chunkey=instance_create(_x,_y,objChunk);
        
                      


//now, get it's "coordinates"
var __x=_x/global.chunk_length;
var __y=_y/global.chunk_length;

var filename_common=global.save_location+"ch."+string(__x)+"."+string(__y)+".unk";
var filename_dat=filename_common+".dat";
var filename_gfx=filename_common+".gfx";

//data...

var build_string="";

var file = file_text_open_read(filename_dat);
while !file_text_eof(file)
{
    build_string = build_string+file_text_read_string(file);
    file_text_readln(file);
}
file_text_close(file);

chunkey.tunnel_data=ds_grid_create(global.cell_count,global.cell_count);

ds_grid_read(chunkey.tunnel_data,build_string);

//and gfx
chunkey.tunnel_gfx=background_add(filename_gfx,0,0);

//other stuff

chunkey.image_xscale=global.chunk_length;
chunkey.image_yscale=global.chunk_length;

chunkey.empty=false; //well, it was loaded from the disk, so it wasn't empty before...

return chunkey;
