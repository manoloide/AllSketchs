#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

uniform float fraction;
uniform float displace;

varying vec4 vertColor;
varying vec3 vertNormal;
varying vec3 vertLightDir;

varying vec4 vertTexCoord;

float rand(vec2 co){
    return fract(sin(dot(co.xy ,vec2(12.9898,78.233))) * 43758.5453);
}

void main() {
    vec4 color = vertColor;
    color.a = vertColor.a*(1.+pow(rand((gl_FragCoord.xy+displace)*0.001), 1.2));

    gl_FragColor = color;
}
