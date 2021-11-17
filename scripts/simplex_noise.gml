///simplex_noise(x, y)
{
    // 2D OpenSimplex2 case uses the same algorithm as ordinary Simplex.

    var SQRT3 = 1.7320508075688772935274463415059;
    var G2 = 0.21132486540518711774542560974902;  //(3 - SQRT3) / 6;
    
    var PRIME_X = 501125321;
    var PRIME_Y = 1136930381;
    /*
     * --- Skew moved to TransformNoiseCoordinate method ---
     * const FNLfloat F2 = 0.5f * (SQRT3 - 1);
     * FNLfloat s = (x + y) * F2;
     * x += s; y += s;
     */
     
    var xx = argument0
    var yy = argument1
    var seed = global.chunk_handler.world_seed

    var i = floor(xx);
    var j = floor(yy);
    var xi = (xx - i);
    var yi = (yy - j);

    var t = (xi + yi) * G2;
    var x0 = xi - t;
    var y0 = yi - t;
    
    i *= PRIME_X;
    j *= PRIME_Y;

    var n0, n1, n2;

    var a = 0.5 - x0 * x0 - y0 * y0;
    if (a <= 0)
        n0 = 0;
    else
    {
        n0 = (a * a) * (a * a) * _grad_coord(i, j, x0, y0);
    }

    var c = (2 * (1 - 2 * G2) * (1 / G2 - 2)) * t + ((-2 * (1 - 2 * G2) * (1 - 2 * G2)) + a);
    if (c <= 0){
        n2 = 0;
    }else{
        var x2 = x0 + (2 * G2 - 1);
        var y2 = y0 + (2 * G2 - 1);
        n2 = (c * c) * (c * c) * _grad_coord(i + PRIME_X, j + PRIME_Y, x2, y2);
    }

    if (y0 > x0){
        x1 = x0 + G2;
        y1 = y0 + (G2 - 1);
        b = 0.5 - x1 * x1 - y1 * y1;
        if (b <= 0){
            n1 = 0;
        }else{
            n1 = (b * b) * (b * b) * _grad_coord(i, j + PRIME_Y, x1, y1);
        }
    }else{
        x1 = x0 + (G2 - 1);
        y1 = y0 + G2;
        b = 0.5 - x1 * x1 - y1 * y1;
        if (b <= 0){
            n1 = 0;
        }else{
            n1 = (b * b) * (b * b) * _grad_coord(i + PRIME_X, j, x1, y1);
        }
    }

    return (n0 + n1 + n2) * 99.83685446303647;
}
