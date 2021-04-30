// Passthrough vertex shader.

attribute vec4 in_Position;
attribute vec2 in_TextureCoord;

varying vec2 v_vTexcoord;

void main() {
    gl_Position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * in_Position;
    
    v_vTexcoord = in_TextureCoord;
}
//######################_==_YOYO_SHADER_MARKER_==_######################@~// This fragment shader looks at the surrounding tiles and determines where there are edges. It sorts the edges so that the edge with the highest z (depth) is drawn below the other edges and so on. The result is packed
// as tile draw instructions into the 4 color channels, one channel per quad (see below), and later unpacked by sh_ats_1's fragment shader which draws the actual tiles.
// For more information on how the shaders work, you can contact me at "http://goo.gl/RMhX5e" or by sending an email to "asbjorn.lystrup@gmail.com".

varying vec2 v_vTexcoord;

uniform vec2 texel_size;

// If your tiles are 16x16, quads represent the different 8x8 parts of your tile sprite. Below, we store a quad as a 2D vector with a z (depth) in its first element and an id in its second.
vec2 quad[4];
vec2 quad_temporary;

void main() {
    // Gets the z values of the current and the orthogonal tiles. The diagonal tiles' z isn't stored as a variable because we only have to reference it once.
    float z_center = dot(texture2D(gm_BaseTexture, v_vTexcoord).zw, vec2(65536.0, 256.0));
    float z_top = dot(texture2D(gm_BaseTexture, v_vTexcoord - vec2(0.0, texel_size.y)).zw, vec2(65536.0, 256.0)); float z_bottom = dot(texture2D(gm_BaseTexture, v_vTexcoord + vec2(0.0, texel_size.y)).zw, vec2(65536.0, 256.0));
    float z_left = dot(texture2D(gm_BaseTexture, v_vTexcoord - vec2(texel_size.x, 0.0)).zw, vec2(65536.0, 256.0)); float z_right = dot(texture2D(gm_BaseTexture, v_vTexcoord + vec2(texel_size.x, 0.0)).zw, vec2(65536.0, 256.0));
    
    // If two of the tiles (not the center) have equal z values and are diagonal to each other, they'll form an inner corner. If inner corners exist, this vector will help change the way the draw instructions are packed.
    vec4 inner_corner = vec4(equal(vec4(z_top, z_top, z_bottom, z_bottom), vec4(z_left, z_right, z_left, z_right)));
    
    // Sorts the quads of the top left tile corner and packs its draw instructions into the first channel.
    quad[0] = vec2(z_center, 0.0); quad[1] = vec2(z_top, 1.0); quad[2] = vec2(z_left - inner_corner.x * 99999.0, 2.0); quad[3] = vec2(dot(texture2D(gm_BaseTexture, v_vTexcoord - texel_size).zw, vec2(65536.0, 256.0)), 3.0);
    for (int i = 0; i < 3; ++i) if (quad[i].x < quad[i + 1].x) {quad_temporary = quad[i]; quad[i] = quad[i + 1]; quad[i + 1] = quad_temporary;}
    for (int i = 0; i < 2; ++i) if (quad[i].x < quad[i + 1].x) {quad_temporary = quad[i]; quad[i] = quad[i + 1]; quad[i + 1] = quad_temporary;}
    if (quad[0].x < quad[1].x) {quad_temporary = quad[0]; quad[0] = quad[1]; quad[1] = quad_temporary;}
    quad[1].y = mix(quad[1].y, quad[0].y, float(quad[1].x == quad[0].x)); quad[2].y = mix(quad[2].y, quad[1].y, float(quad[2].x == quad[1].x));
    gl_FragColor.x = dot(vec4(quad[0].y, quad[1].y, quad[2].y, mix(mix(quad[3].y, quad[2].y, float(quad[3].x == quad[2].x)), quad[0].y, inner_corner.x)), vec4(64.0 / 255.0, 16.0 / 255.0, 4.0 / 255.0, 1.0 / 255.0));

    // Sorts the quads of the top right tile corner and packs its draw instructions into the second channel.
    quad[0] = vec2(z_center, 0.0); quad[1] = vec2(z_top, 1.0); quad[2] = vec2(z_right - inner_corner.y * 99999.0, 2.0); quad[3] = vec2(dot(texture2D(gm_BaseTexture, v_vTexcoord + vec2(texel_size.x, -texel_size.y)).zw, vec2(65536.0, 256.0)), 3.0);
    for (int i = 0; i < 3; ++i) if (quad[i].x < quad[i + 1].x) {quad_temporary = quad[i]; quad[i] = quad[i + 1]; quad[i + 1] = quad_temporary;}
    for (int i = 0; i < 2; ++i) if (quad[i].x < quad[i + 1].x) {quad_temporary = quad[i]; quad[i] = quad[i + 1]; quad[i + 1] = quad_temporary;}
    if (quad[0].x < quad[1].x) {quad_temporary = quad[0]; quad[0] = quad[1]; quad[1] = quad_temporary;}
    quad[1].y = mix(quad[1].y, quad[0].y, float(quad[1].x == quad[0].x)); quad[2].y = mix(quad[2].y, quad[1].y, float(quad[2].x == quad[1].x));
    gl_FragColor.y = dot(vec4(quad[0].y, quad[1].y, quad[2].y, mix(mix(quad[3].y, quad[2].y, float(quad[3].x == quad[2].x)), quad[0].y, inner_corner.y)), vec4(64.0 / 255.0, 16.0 / 255.0, 4.0 / 255.0, 1.0 / 255.0));
    
    // Sorts the quads of the bottom left tile corner and packs its draw instructions into the third channel.
    quad[0] = vec2(z_center, 0.0); quad[1] = vec2(z_bottom, 1.0); quad[2] = vec2(z_left - inner_corner.z * 99999.0, 2.0); quad[3] = vec2(dot(texture2D(gm_BaseTexture, v_vTexcoord + vec2(-texel_size.x, texel_size.y)).zw, vec2(65536.0, 256.0)), 3.0);
    for (int i = 0; i < 3; ++i) if (quad[i].x < quad[i + 1].x) {quad_temporary = quad[i]; quad[i] = quad[i + 1]; quad[i + 1] = quad_temporary;}
    for (int i = 0; i < 2; ++i) if (quad[i].x < quad[i + 1].x) {quad_temporary = quad[i]; quad[i] = quad[i + 1]; quad[i + 1] = quad_temporary;}
    if (quad[0].x < quad[1].x) {quad_temporary = quad[0]; quad[0] = quad[1]; quad[1] = quad_temporary;}
    quad[1].y = mix(quad[1].y, quad[0].y, float(quad[1].x == quad[0].x)); quad[2].y = mix(quad[2].y, quad[1].y, float(quad[2].x == quad[1].x));
    gl_FragColor.z = dot(vec4(quad[0].y, quad[1].y, quad[2].y, mix(mix(quad[3].y, quad[2].y, float(quad[3].x == quad[2].x)), quad[0].y, inner_corner.z)), vec4(64.0 / 255.0, 16.0 / 255.0, 4.0 / 255.0, 1.0 / 255.0));
    
    // Sorts the quads of the bottom right tile corner and packs its draw instructions into the fourth channel.
    quad[0] = vec2(z_center, 0.0); quad[1] = vec2(z_bottom, 1.0); quad[2] = vec2(z_right - inner_corner.w * 99999.0, 2.0); quad[3] = vec2(dot(texture2D(gm_BaseTexture, v_vTexcoord + texel_size).zw, vec2(65536.0, 256.0)), 3.0);
    for (int i = 0; i < 3; ++i) if (quad[i].x < quad[i + 1].x) {quad_temporary = quad[i]; quad[i] = quad[i + 1]; quad[i + 1] = quad_temporary;}
    for (int i = 0; i < 2; ++i) if (quad[i].x < quad[i + 1].x) {quad_temporary = quad[i]; quad[i] = quad[i + 1]; quad[i + 1] = quad_temporary;}
    if (quad[0].x < quad[1].x) {quad_temporary = quad[0]; quad[0] = quad[1]; quad[1] = quad_temporary;}
    quad[1].y = mix(quad[1].y, quad[0].y, float(quad[1].x == quad[0].x)); quad[2].y = mix(quad[2].y, quad[1].y, float(quad[2].x == quad[1].x));
    gl_FragColor.w = dot(vec4(quad[0].y, quad[1].y, quad[2].y, mix(mix(quad[3].y, quad[2].y, float(quad[3].x == quad[2].x)), quad[0].y, inner_corner.w)), vec4(64.0 / 255.0, 16.0 / 255.0, 4.0 / 255.0, 1.0 / 255.0));
}
