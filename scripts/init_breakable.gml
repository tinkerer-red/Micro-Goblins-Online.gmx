///init_breakable( amount )
/*
 * Initialize the breakable object and set the number of pieces to break into
 *
 * Params:
 *  amount - The severity of the break (1-3)
 *    * INVALID AMOUND - defaults to 1
 *
 * Return:
 *  array of sprite pieces 
 */

//manually configure physics
global.phy_set = false;

amount = argument0;
if(amount > 3 || amount < 1){
  amount = 1;
}
pieces = power(amount+1,2);
var sp;

for(i=0;i<pieces;i++)
  {
    surf = surface_create(sprite_width, sprite_height);
    surface_set_target(surf);
    //draw_sprite_ext(sprite_index, image_index, 0,0, image_xscale, image_yscale, 0, c_white, 1);  
    draw_sprite_ext(sprite_index, image_index, sprite_get_xoffset(sprite_index),sprite_get_yoffset(sprite_index), image_xscale, image_yscale, 0, c_white, 1);  
    
    /* handle the offset */
    sx = 0;
    sy = 0;
    perfect = sqrt(pieces);
    switch (perfect)
      {
      case 1:
        if(i%2 != 0){
          sx = sprite_width/2;
        }
        if(i>1){
          sy = sprite_height/2;
        }
        break;
      case 2:
        if(i%3==0){
          sx = 0;
        }else if(i%3==1){
          sx = sprite_width/3;
        }else if(i%3==2){
          sx = 2 * sprite_width/3;
        }

        if(i>2 && i <6) {
          sy = sprite_height/3;
        }else if(i>5) {
          sy = 2 * sprite_height/3;
        }
        break;
      case 3:
        if(i%4==0){
          sx = 0;
        }else if(i%4==1){
          sx = sprite_width/4;
        }else if(i%4==2){
          sx = 2*sprite_width/4
        }else if(i%4==3){
          sx = 3*sprite_width/4
        }

        if(i>3 && i <8){
          sy = sprite_height/4;
        }else if(i>7 && i<12){
          sy = 2*sprite_height/4;
        }else if(i>11){
           sy = 3*sprite_height/4;
        }
        break;
      }
    
    sp[i] = sprite_create_from_surface(surf, sx, sy, sprite_width/perfect, sprite_height/perfect, false, false, 0,0);
    surface_reset_target();
    surface_free(surf);  
  }
return sp;
