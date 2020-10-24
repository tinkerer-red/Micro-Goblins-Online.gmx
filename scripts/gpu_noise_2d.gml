/// gpu_noise_2d(noise_object, x, y);

var o = argument[0];
var _width  = o[@1];
var _height = o[@2];
var _x = argument[1];
var _y = argument[2];
var _xoffset = o[@6];
var _yoffset = o[@7];

if (_x > _width) {
    var _xdiv = _x div _width;
    _x = _x mod _width;
    _xoffset = _xdiv * _width;
}

if (_y > _height) {
    var _ydiv = _y div _height;
    _y = _y mod _height;
    _yoffset = _ydiv * _height;
}

if (_xoffset != o[@6] || _yoffset != o[@7]) o = gpu_noise_offset(o, _xoffset, _yoffset);

/////////
/*
                    var XIndex = floor(_x);
                    var remX = _x - XIndex; // Remainder from x for calculatin interpolation.
                    
                    var YIndex = floor(_y);
                    var remY = _y - YIndex; // Remainder from y for calculatin interpolation.
                    
                    // Get closest points, for interpolation.
                    var a = (buffer_peek(o[@10], (_x+_y*_width)*4, buffer_u32) & 255) / 255;
                    var b = (buffer_peek(o[@10], ((_x+1)+_y*_width)*4, buffer_u32) & 255) / 255;
                    var c = (buffer_peek(o[@10], (_x+(_y+1)*_width)*4, buffer_u32) & 255) / 255;
                    var d = (buffer_peek(o[@10], ((_x+1)+(_y+1)*_width)*4, buffer_u32) & 255) / 255;
                    
                    // Cosine interpolation.
                    var ftx = remX * pi;
                    var fx = (1 - cos(ftx)) / 2;    
                    
                    var i1 = a * (1 - fx) + b * fx;
                    var i2 = c * (1 - fx) + d * fx;
                    
                    var fty = remY * pi;
                    var fy = (1 - cos(fty)) / 2;
                    
                    var interpolated = i1 * (1 - fy) + i2 * fy;
                    
                    return interpolated;
*//////////


return (buffer_peek(o[@10], (_x+_y*_width)*4, buffer_u32) & 255) / 255;
