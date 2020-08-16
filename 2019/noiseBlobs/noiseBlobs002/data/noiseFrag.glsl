#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

#define PROCESSING_COLOR_SHADER


varying vec4 vertColor;
varying vec4 vertTexCoord;

uniform float displace;

float rand(vec2 co){
    return fract(sin(dot(co.xy ,vec2(12.9898,78.233))) * 43758.5453);
}

void main() {
    vec4 color = vertColor;
    float noi = pow((1.-pow(rand((gl_FragCoord.xy+displace)*0.001), 0.2)), 0.6);
    //color.r *= noi;
    color.a = pow(vertColor.a, 1.4)*(0.7-noi*0.3);

    gl_FragColor = color;
}
