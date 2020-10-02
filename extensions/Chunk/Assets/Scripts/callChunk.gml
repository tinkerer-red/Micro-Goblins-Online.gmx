///callChunk(x,y)
//this function calls the chunk as apparently the chunk is needed there.
//BUT WAIT, THERE'S MORE.
//
//We can treat it pretty abstract,
//As in, if a chunk already exists there, just return it.
//If not, create a new one.
//
//Sneaky, huh. That way you ALWAYS get a chunk instance 
//it will create a chunk at a given multiple of chunk size and and the x,y coordinates,
//then, the chunk is going to check if corresponding data exists on disk.
//if not, the chunk is going to generate itself.

//if it exists, the chunk is going to load itself.


//doesn't matter if loaded or generated - now it's time
//to assign the structural data, like the corresponding
//backgrounds. Either from the already existing bitmap,
//or an entirely new one.

var _x=argument[0];
var _y=argument[1];

var requested_chunk=noone;

var test_chunk=chunkAtPos(_x,_y);
//this functions sets two temp registers,
//global.temp[0] and global.temp[1],
//to the "snapped" values of x and y,
//so you don't have to do that again in case you
//need to create a new chunk.

if (test_chunk==noone)
{
    //now it's time to decide whether to generate or load
    
    //get it's "coordinates"
    var _x=global.temp[0];
    var _y=global.temp[1];
    
    var __x=_x/global.chunk_length;
    var __y=_y/global.chunk_length;

    var filename_common=global.save_location+"ch."+string(__x)+"."+string(__y)+".unk";
    var filename_dat=filename_common+".dat";
    var filename_gfx=filename_common+".gfx";
    
    //now check if the dat file exists.
    //if the gfx file doesn't exist, that's fine, just give the user a warning that the gfx
    //needs to be regenerated.
    //yes.
    //
    if (file_exists(filename_dat))
        {
        requested_chunk=chunkLoadFromDisk(_x,_y);
        //that scripts takes care of everything
        }
    else
        {
        //we're generating
    
        requested_chunk=instance_create(_x,_y,objChunk);
        with (requested_chunk)
            {
        
            tunnel_data=ds_grid_create(global.cell_count,global.cell_count);
            tunnel_gfx=background_duplicate(bgBlankCanvas);
            background_set_alpha_from_background(tunnel_gfx,tunnel_gfx);
                      
            image_xscale=global.chunk_length;
            image_yscale=global.chunk_length;
            
            //for now, yeah, it's gonna be empty
            empty=true;
            }
        }
    return requested_chunk;
    }
else
    {
    return test_chunk;
    }
