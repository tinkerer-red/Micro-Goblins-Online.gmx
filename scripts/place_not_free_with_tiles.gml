///place_free_with_tiles(x,y)

xx = argument0
yy = argument1

if place_free(xx, yy) {
  return true
}else{
  if !tile_meeting_precise(xx, yy, TileLayerBottom){
    return true
  }
}

return false
