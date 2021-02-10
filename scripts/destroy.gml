/* destroy( breakable_id, copy_id )
 * Destroys the calling instance into pieces
 *
 * Params:
 *    breakable_id : variable init_breakable was set to
 *    copy_id : object to copy physics properties from
 * Return:
 *    N/A
*/

breakable_id = argument0;
copy_id = argument1;

pieces = array_length_1d(breakable_id);

for(i=0;i<pieces;i++)
  {
    sx = 0+i*sprite_width/pieces;
    sy = irandom_range(0,sprite_height/2);

    o = instance_create(x+sx,y+sy,o_breakable_piece);
    o.sprite_index = breakable_id[i];
    
    WIDTH = sprite_get_width(breakable_id[i])/2;
    HEIGHT = sprite_get_height(breakable_id[i])/2;
    
    // handle breaking
    if(global.phy_set){
      f = physics_fixture_create();
      physics_fixture_set_density(f, 0.5);
      physics_fixture_set_box_shape(f, WIDTH, HEIGHT);
      physics_fixture_bind_ext(f, o, -WIDTH, -HEIGHT);

      phy_rotation = irandom_range(0,180);
      
      if(copy_id!=noone)
        {
          o.phy_angular_velocity = copy_id.phy_angular_velocity;
          o.phy_linear_velocity_x = copy_id.phy_linear_velocity_x;
          o.phy_linear_velocity_y = copy_id.phy_linear_velocity_y;
          o.phy_speed_x = copy_id.phy_speed_x;
          o.phy_speed_y = copy_id.phy_speed_y;
        }
      with(o){
        physics_apply_impulse(x+sprite_width/2,y+sprite_height,irandom_range(-2,2),irandom_range(-3,1));
      }
    }else{
      // handle breaking in a world without physics
    }
  }

instance_destroy();
