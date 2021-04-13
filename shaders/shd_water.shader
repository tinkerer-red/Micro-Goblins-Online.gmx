attribute vec3 in_Position;                  // (x,y,z)
// attribute vec3 in_Normal;                   // (x,y,z)     unused in this shader.
attribute vec4 in_Colour;                    // (r,g,b,a)
attribute vec2 in_TextureCoord;              // (u,v)

varying vec2 v_vTexcoord;
varying vec4 v_vColour;

void main()
{
    vec4 object_space_pos = vec4( in_Position.x, in_Position.y, in_Position.z, 1.0);
    gl_Position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * object_space_pos;
    
    v_vColour = in_Colour;
    v_vTexcoord = in_TextureCoord;
}
//######################_==_YOYO_SHADER_MARKER_==_######################@~varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform sampler2D displacementMap;
uniform float time;

void main() {
    vec2 time_offset = vec2(time, -time / 2.0) / 4.0;
    vec4 displace = texture2D(displacementMap, v_vTexcoord + time_offset);
    float brightness = ((displace.r + displace.g + displace.b) / 15.0) - 0.25;
    vec2 offset = vec2(brightness, (-brightness+displace.b/4.0)) / 2.0 + time/8.0;
    //vec2 offset = ;
    gl_FragColor = v_vColour * texture2D(gm_BaseTexture, v_vTexcoord + offset);
}
