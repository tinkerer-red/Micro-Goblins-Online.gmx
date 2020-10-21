var w = argument0;
var h = argument1;
var tt = argument2 - 10; // Variable to check the terrain type nearby. It's Island generator, so it will look for "lower elevated" terrain.

var wp = w + 1; // Variables for out-of-bounds prevention.
var hp = h + 1;
var wm = w - 1;
var hm = h - 1;

var img_index,north_tile,south_tile,west_tile,east_tile,north_east_tile,north_west_tile,south_east_tile,south_west_tile; // Main variables.

// Bunch of out-of-bounds prevention checks, as suggested here: http://gmc.yoyogames.com/index.php?showtopic=691449
// Not too elegant, but works fast and easy to implement.

//== North
if (w < 0) or (w > width - 1) or (hm < 0) or (hm > height - 1)
{
    north_tile = 0; // If North tile is out-of-bounds return 0
}
else
{
    if(ds_grid_get(grid, w, hm) != tt){north_tile = 1} else {north_tile = 0}; // Check if North tile exists and if it's the right terrain type, if it is, return 1, else 0.
}

//== South
if (w < 0) or (w > width - 1) or (hp < 0) or (hp > height - 1)
{
    south_tile = 0;
}
else
{
    if(ds_grid_get(grid, w, hp) != tt){south_tile = 1} else {south_tile = 0};
}

//== West
if (wm < 0) or (wm > width - 1) or (h < 0) or (h > height - 1)
{
    west_tile = 0;
}
else
{
    if(ds_grid_get(grid, wm, h) != tt){west_tile = 1} else {west_tile = 0};
}

//== East
if (wp < 0) or (wp > width - 1) or (h < 0) or (h > height - 1)
{
    east_tile = 0;
}
else
{
    if(ds_grid_get(grid, wp, h) != tt){east_tile = 1} else {east_tile = 0};
}

// Diagonal checks.

//== North West
if (wm < 0) or (wm > width - 1) or (hm < 0) or (hm > height - 1)
{
    north_west_tile = 0;
}
else
{
    if(ds_grid_get(grid, wm, hm) != tt && west_tile = 1 && north_tile = 1){north_west_tile = 1} else {north_west_tile = 0};
}

//== North East
if (wp < 0) or (wp > width - 1) or (hm < 0) or (hm > height - 1)
{
    north_east_tile = 0;
}
else
{
    if(ds_grid_get(grid, wp, hm) != tt && north_tile = 1 && east_tile = 1){north_east_tile = 1} else {north_east_tile = 0};
}

//== South West
if (wm < 0) or (wm > width - 1) or (hp < 0) or (hp > height - 1)
{
    south_west_tile = 0;
}
else
{
    if(ds_grid_get(grid, wm, hp) != tt && south_tile = 1 && west_tile = 1){south_west_tile = 1} else {south_west_tile = 0};
}

//== South East
if (wp < 0) or (wp > width - 1) or (hp < 0) or (hp > height - 1)
{
    south_east_tile = 0;
}
else
{
    if(ds_grid_get(grid, wp, hp) != tt && south_tile = 1 && east_tile = 1){south_east_tile = 1} else {south_east_tile = 0};
}

// Calculating final bitmask value.
var index = north_west_tile + 2*north_tile + 4*north_east_tile + 8*west_tile + 16*east_tile + 32*south_west_tile + 64*south_tile + 128*south_east_tile;

// Check the DS_MAP for tile index corresponding to bitmask value.
var img_index = ds_map_find_value(global.tile_map,string(index));

return img_index;
