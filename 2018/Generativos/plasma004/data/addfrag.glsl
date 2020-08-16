#define PROCESSING_COLOR_SHADER

#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

uniform sampler2D texture;
uniform vec2 texOffset;

varying vec4 vertColor;
varying vec4 vertTexCoord;

void main() {
    vec4 back = texture2D(texture, vertTexCoord.st)*vertColor;
    
    gl_FragColor = vec4(vec3(vertColor.rgb*1.2), vertColor.a*2.0);
}
