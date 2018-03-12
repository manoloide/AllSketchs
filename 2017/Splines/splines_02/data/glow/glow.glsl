// Adapted from:
// http://callumhay.blogspot.com/2010/09/gaussian-blur-shader-glsl.html

//@edumo second adapted for processing 2 from http://forum.devmaster.net/t/shader-effects-glow-and-bloom/3100

#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

#define PROCESSING_TEXTURE_SHADER

uniform sampler2D texture;
uniform sampler2D Sample1;
uniform int BlendMode;

// The inverse of the texture dimensions along X and Y
uniform vec2 texOffset;

varying vec4 vertColor;
varying vec4 vertTexCoord;

void main() {  

 	vec4 dst = texture2D(texture, vertTexCoord.st); // rendered scene
    vec4 src = texture2D(Sample1, vertTexCoord.st); // glowmap

    if ( BlendMode == 0 )
    {
        // Additive blending (strong result, high overexposure)
        gl_FragColor = min(src + dst, 1.0);
    }
    else if ( BlendMode == 1 )
    {
        // Screen blending (mild result, medium overexposure)
        gl_FragColor = clamp((src + dst) - (src * dst), 0.0, 1.0);
        gl_FragColor.w = 1.0;
    }
   
    else
    {
        // Show just the glow map
        gl_FragColor = src;
    }
    
  // gl_FragColor = texture2D(texture, vertTexCoord.st);
}
