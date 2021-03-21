//
// Simple passthrough vertex shader
//
attribute vec3 in_Position;                  // (x,y,z)
//attribute vec3 in_Normal;                  // (x,y,z)     unused in this shader.
attribute vec4 in_Colour;                    // (r,g,b,a)
attribute vec2 in_TextureCoord;              // (u,v)

varying vec2 v_vTexcoord;
varying vec4 v_vColour;

void main()
{
    vec4 object_space_pos = vec4(in_Position.x, in_Position.y, in_Position.z, 1.0);
    gl_Position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * object_space_pos;
    
    v_vColour = in_Colour;
    v_vTexcoord = in_TextureCoord;
}

//######################_==_YOYO_SHADER_MARKER_==_######################@~varying vec2 v_vTexcoord;
varying vec4 v_vColour;
uniform float u_Position;

// https://en.wikipedia.org/wiki/YIQ

const mat3 rgb2yiq = mat3(0.299, 0.587, 0.114, 0.595716, -0.274453, -0.321263, 0.211456, -0.522591, 0.311135);
const mat3 yiq2rgb = mat3(1.0, 0.9563, 0.6210, 1.0, -0.2721, -0.6474, 1.0, -1.1070, 1.7046);

void main()
{
    vec4 tColor = texture2D(gm_BaseTexture, v_vTexcoord);
    vec3 yColor = (tColor.rgb * v_vColour.rgb) * rgb2yiq; 

    float originalHue = atan(yColor.b, yColor.g);
    float finalHue = originalHue + u_Position;

    float chroma = sqrt(yColor.b * yColor.b + yColor.g * yColor.g);
    
    vec3 yFinalColor = vec3(yColor.r, chroma * cos(finalHue), chroma * sin(finalHue));
    
    gl_FragColor = vec4(yFinalColor * yiq2rgb, tColor.a * v_vColour.a);
}
