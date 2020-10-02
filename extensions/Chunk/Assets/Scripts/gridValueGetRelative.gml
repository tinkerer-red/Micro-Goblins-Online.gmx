///gridValueGetRelative(relative_grid_x,relative_grid_y,calling_chunk)
//first, turn the coordinates back into absolute screen coordinates.
//temp[5] will give us chunk that's there.
//still the same chunk? proceed.
//but if it's a different chunk,
//do a modulo on the coordinates.

//now use moduloed coordinates from the arguments
//to look up a value in the (for now, just tunnel) grid.
//add more types of grids later.
//like clay, dirt, silt ratios, etc.
var _x=argument[0];
var _y=argument[1];

var chunkey=argument[2];

gridRelativeToScreenAbsolute(_x,_y,chunkey);

var that_chunk=global.temp[5];

//now the modulo matters

    {
    _x=modulo_euclidian(_x,global.cell_count);
    _y=modulo_euclidian(_y,global.cell_count);
    }

var that_grid=that_chunk.tunnel_data; //or. you know, whatever



return that_grid[# _x, _y];
