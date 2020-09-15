//
// Simple passthrough vertex shader
//

attribute vec3 in_Position;                  // (x,y,z)
//attribute vec3 in_Normal;                  // (x,y,z)     unused in this shader.
attribute vec4 in_Colour;                    // (r,g,b,a)
attribute vec2 in_TextureCoord;              // (u,v)

varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform float time;
uniform float value;

float noise( float n ) {
    return -1.0+2.0*fract(sin(n)*21567.5471);
}

void main()
{
    
    vec4 object_space_pos = vec4( vec3(in_Position), 1.0);
    
    object_space_pos.xyz += normalize(object_space_pos.xyz) * (noise(object_space_pos.x + time) * value * 64.0);
        
    gl_Position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * object_space_pos;
        
    v_vColour = in_Colour;
    v_vTexcoord = in_TextureCoord;
}

//######################_==_YOYO_SHADER_MARKER_==_######################@~//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

void main()
{
    gl_FragColor = v_vColour * texture2D( gm_BaseTexture, v_vTexcoord );
}

