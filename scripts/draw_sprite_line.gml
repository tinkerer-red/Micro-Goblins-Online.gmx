///draw_sprite_line(sprite, x1, y1, x2, y2, [width])

var sprite = argument[0]
var x1 = argument[1]
var y1 = argument[2]
var x2 = argument[3]
var y2 = argument[4]


//find out what the ideal width is
    if (argument_count = 6){
        ideal_width = argument[5]
    }else{
        ideal_width = sprite_get_height(sprite);
    }

//grab the image length, relative to the image scale
    if (ideal_width != sprite_get_width(sprite)){
      var scale = ideal_width / sprite_get_height(sprite)
    }else{
      var scale = 1
    }

// set the length so we dont have to do the math for it every time we need it.        
    ideal_length = sprite_get_width(sprite)*scale
    
//find the direction, and how much to add to x and y for each
    var _dir = point_direction(x1, y1, x2, y2)
    var _dist = point_distance(x1, y1, x2, y2)
    
    var xi = lengthdir_x(ideal_length, _dir)
    var yi = lengthdir_y(ideal_length, _dir)
    
    var dist_trav = 0
    var xx = x1
    var yy = y1
    
    while (dist_trav < _dist){
        //if we're about to finish off the drawing draw only a part of it
//        if ((_dist - dist_trav) < ideal_length){
        
//        }else{ //draw the entire sprite if we're not cose to being done
            draw_sprite_ext(sprite, 0, xx, yy, scale, scale, _dir, c_white, 1)
            xx += xi
            yy += yi
            dist_trav += ideal_length
//        }
    }
    


