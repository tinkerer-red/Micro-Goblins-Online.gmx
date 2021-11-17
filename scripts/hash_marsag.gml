///hash_marsag(x, y)


//George Marsaglia's Hash function
var a = argument0
var yy = argument1
//var a = xx*6969+yy*420420

    a = (a ^ 61) ^ (a >> 16);
    a = a + (a << 3);
    a = a ^ (a >> 4);
    a = a * $27d4eb2d;
    a = a ^ (a >> 15);
    
    yy = (yy ^ 61) ^ (yy >> 16);
    yy = yy + (yy << 3);
    yy = yy ^ (yy >> 4);
    yy = yy * $d2be4d72;
    yy = yy ^ (yy >> 15);
    
    //show_debug_message(a*yy mod 5000000 / 5000000)
    return (a+yy) mod 5000000 / 5000000;
