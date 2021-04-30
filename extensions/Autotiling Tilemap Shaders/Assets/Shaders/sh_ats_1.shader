// Passthrough vertex shader.

attribute vec4 in_Position;
attribute vec2 in_TextureCoord;

varying vec2 v_vTexcoord;

void main() {
    gl_Position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * in_Position;
    
    v_vTexcoord = in_TextureCoord;
}
//######################_==_YOYO_SHADER_MARKER_==_######################@~// This fragment shader reads the draw instructions generated from sh_ats_0 (texture_quads), and finds the uvs (gm_BaseTexture) and texture data (texture_tiles) to draw the edges in the correct order.
// For more information on how the shaders work, you can contact me at "http://goo.gl/RMhX5e" or by sending an email to "asbjorn.lystrup@gmail.com".

varying vec2 v_vTexcoord;

uniform sampler2D texture_tiles;
uniform sampler2D texture_quads;
uniform vec4 precalculated_0; // x: the width of the quad being drawn. y: the height of the quad being drawn. z: texture_tiles texel width. w: texture_tiles texel height.
uniform vec4 precalculated_1; // x: texture_quads texel width. y: texture_quads texel height. z: the width of a cell in pixels. w: the height of a cell in pixels.

vec2 offset_quad[4];
vec2 offset_tile[4];

void main() {
    // A vector with x and y in the range [0, 8) representing the fragment position relative to the tile corner being drawn.
    vec2 offset_mod = mod(v_vTexcoord * precalculated_0.xy, precalculated_1.zw * 0.5);
    
    // Creates a color channel index (0 for red, 1, for green, 2 for blue, 3 for alpha) for the tile corner being drawn.
    int corner_index = int(dot(vec2(greaterThanEqual(mod(v_vTexcoord * precalculated_0.xy, precalculated_1.zw), precalculated_1.zw * 0.5)), vec2(1.0, 2.0)));
    
    // Unpacks the draw instructions from the channel corresponding to the tile corner being drawn.
    float quads = texture2D(texture_quads, v_vTexcoord)[corner_index];
    ivec4 quad = ivec4(quads * (255.5 / 64.0), quads * (255.5 / 16.0), quads * (255.5 / 4.0), quads * 255.5) - ivec4(0, quads * (255.5 / 64.0), quads * (255.5 / 16.0), quads * (255.5 / 4.0)) * 4;
    
    // inner_corner is set to 1.0 if one of the quads is an inner corner. This will affect the offset arrays. The last quad is ignored if inner_corner is 1.0.
    float inner_corner = float(quad.x == quad.w);
    quad.w = int(mix(float(quad.w), float(quad.z), inner_corner));
    
    // Sets various offsets dependent on which tile corner is being drawn.
    if (corner_index == 0) {
        offset_quad[0] = precalculated_1.zw * 0.5; offset_quad[1] = mix(precalculated_1.zw * vec2(0.5, 1.5), vec2(precalculated_1.z * 2.0, 0.0), inner_corner); offset_quad[2] = precalculated_1.zw * vec2(1.5, 0.5); offset_quad[3] = precalculated_1.zw * 1.5;
        offset_tile[0] = vec2(0.0); offset_tile[1] = vec2(0.0, -precalculated_1.y); offset_tile[2] = vec2(-precalculated_1.x, 0.0); offset_tile[3] = -precalculated_1.xy;
    } else if (corner_index == 1) {
        offset_quad[0] = precalculated_1.zw * vec2(1.0, 0.5); offset_quad[1] = mix(precalculated_1.zw * vec2(1.0, 1.5), precalculated_1.zw * vec2(2.0, 1.0), inner_corner); offset_quad[2] = vec2(0.0, precalculated_1.w * 0.5); offset_quad[3] = vec2(0.0, precalculated_1.w * 1.5);
        offset_tile[0] = vec2(0.0); offset_tile[1] = vec2(0.0, -precalculated_1.y); offset_tile[2] = vec2(precalculated_1.x, 0.0); offset_tile[3] = vec2(precalculated_1.x, -precalculated_1.y);
    } else if (corner_index == 2) {
        offset_quad[0] = precalculated_1.zw * vec2(0.5, 1.0); offset_quad[1] = mix(vec2(precalculated_1.z * 0.5, 0.0), precalculated_1.zw * vec2(2.0, 0.5), inner_corner); offset_quad[2] = precalculated_1.zw * vec2(1.5, 1.0); offset_quad[3] = vec2(precalculated_1.z * 1.5, 0.0);
        offset_tile[0] = vec2(0.0); offset_tile[1] = vec2(0.0, precalculated_1.y); offset_tile[2] = vec2(-precalculated_1.x, 0.0); offset_tile[3] = vec2(-precalculated_1.x, precalculated_1.y);
    } else {
        offset_quad[0] = precalculated_1.zw; offset_quad[1] = mix(vec2(precalculated_1.z, 0.0), precalculated_1.zw * vec2(2.0, 1.5), inner_corner); offset_quad[2] = vec2(0.0, precalculated_1.w); offset_quad[3] = vec2(0.0);
        offset_tile[0] = vec2(0.0); offset_tile[1] = vec2(0.0, precalculated_1.y); offset_tile[2] = vec2(precalculated_1.x, 0.0); offset_tile[3] = precalculated_1.xy;
    }
    
    // Blends together colors from tile edges, corners and fill.
    gl_FragColor = texture2D(texture_tiles, (texture2D(gm_BaseTexture, v_vTexcoord + offset_tile[quad[0]]).xy * precalculated_1.zw * vec2(2.5 * 255.0, 2.0 * 255.0) + offset_quad[quad[0]] + offset_mod) * precalculated_0.zw);
    for (int i = 1; i < 4; ++i) {
        vec4 src = float(quad[i] != quad[i - 1]) * texture2D(texture_tiles, (texture2D(gm_BaseTexture, v_vTexcoord + offset_tile[quad[i]]).xy * precalculated_1.zw * vec2(2.5 * 255.0, 2.0 * 255.0) + offset_quad[quad[i]] + offset_mod) * precalculated_0.zw);
        gl_FragColor += src - src.a * gl_FragColor;
    }
}
