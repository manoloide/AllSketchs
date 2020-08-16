#ifdef GL_ES
precision highp float;
precision highp int;
#endif

#define PROCESSING_TEXTURE_SHADER

varying vec4 vertTexCoord;
uniform sampler2D texture;

void main () {
    vec3 color = texture2D(texture, vertTexCoord.st).rgb;
    
    color.r = pow(color.r, 1.2);
    gl_FragColor = vec4(color, 1.0);
}
