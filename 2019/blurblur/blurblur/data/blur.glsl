#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

#define PROCESSING_TEXTURE_SHADER

uniform sampler2D texture;
uniform vec2 texOffset;
uniform vec2 direction;

varying vec4 vertColor;
varying vec4 vertTexCoord;

vec4 blur13(sampler2D image, vec2 direction) {
    vec4 color = vec4(0.0);
    vec2 off1 = vec2(1.411764705882353) * direction;
    vec2 off2 = vec2(3.2941176470588234) * direction;
    vec2 off3 = vec2(5.176470588235294) * direction;
    color += texture(image, vertTexCoord.st) * 0.1964825501511404;
    color += texture(image, vertTexCoord.st + (off1)) * 0.2969069646728344;
    color += texture(image, vertTexCoord.st - (off1)) * 0.2969069646728344;
    color += texture(image, vertTexCoord.st + (off2)) * 0.09447039785044732;
    color += texture(image, vertTexCoord.st - (off2)) * 0.09447039785044732;
    color += texture(image, vertTexCoord.st + (off3)) * 0.010381362401148057;
    color += texture(image, vertTexCoord.st - (off3)) * 0.010381362401148057;
    return color;
}

void main(void){
    
    vec4 col = texture(texture, vertTexCoord.xy);
    gl_FragColor = blur13(texture, direction) * vertColor;

}
