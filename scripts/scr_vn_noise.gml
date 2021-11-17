///scr_vn_noise(min, max, octaves, persistence, freq, seed, method, x, [y, z]);

var minVal = argument[0],
    maxVal = argument[1],
    octaves = argument[2],
    persistence = argument[3],
    freq = argument[4],
    seed = argument[5],
    method = argument[6],
    amp = 1, 
    maxamp = 0, 
    sum = 0;

for (var i=0; i < octaves; ++i) {
    
    switch (argument_count) {
        case 8:
            sum += amp * _vn_noise2d(seed, freq*argument[7], 0); 
            break;
        case 9:
            if (method = 0) sum += amp * _vn_noise2d(seed, freq*argument[7], freq*argument[8]); 
            if (method >= 1) sum += amp * single_cellular(seed, method, freq*argument[7], freq*argument[8]); 
            break;
        case 10:
            sum += amp * _vn_noise3d(freq*argument[7], freq*argument[8], freq*argument[9]); 
            break;        
    }
    freq *= 2;
    maxamp += amp;
    amp *= persistence;
    
}

return (sum / maxamp) * (maxVal - minVal) / 2 + (maxVal + minVal) / 2;
