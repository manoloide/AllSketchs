#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

#define PROCESSING_TEXTURE_SHADER


varying vec4 vertColor;
varying vec4 vertTexCoord;

uniform float displace;

float rand(vec2 co){
    return fract(sin(dot(co.xy ,vec2(12.9898,78.233))) * 43758.5453);
}

void main() {
    vec4 color = vertColor;
    float noi = (1.-pow(rand((gl_FragCoord.xy+displace)*0.001), 3.0));
    color.r *= noi;
    color.a = vertColor.a*noi;

    gl_FragColor = color;
}
