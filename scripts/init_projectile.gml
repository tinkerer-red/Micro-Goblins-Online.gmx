///init_projectile(projectile_id)

var proj = argument[0];

//copy the last of the queues to the projectile
proj.weapon_event_queues = ds_priority_create()
ds_priority_copy(proj.weapon_event_queues, self.weapon_event_queues)

//proj.direction = direction
proj.image_angle = proj.direction-45

proj.sprite_index = sprite_proj
proj.sprite_aoe = sprite_aoe
proj.w_hype = fast_hype(proj.sprite_height, proj.sprite_width)
//if (proj.sprite_index = sprite_index) {proj.image_angle -= 45}

proj.image_xscale = w_size
proj.image_yscale = w_size

proj.owner_id = owner_id

proj.start_x = proj.x
proj.start_y = proj.y

proj.w_damage = w_damage
//proj.w_range = w_range
proj.w_knockback = w_knockback
proj.speed = self.proj_speed //w_speed

proj.projectile_active = true
