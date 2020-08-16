#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

#define PROCESSING_TEXTURE_SHADER

uniform sampler2D texture;
uniform vec2 texOffset;
uniform vec2 direction;
uniform float time;

varying vec4 vertColor;
varying vec4 vertTexCoord;

// 2D Random
float random (in vec2 st) {
    return fract(sin(dot(st.xy,vec2(12.9898,78.233)))*43758.5453123);
}

// 2D Noise based on Morgan McGuire @morgan3d
// https://www.shadertoy.com/view/4dS3Wd
float noise (in vec2 st) {
    vec2 i = floor(st);
    vec2 f = fract(st);
    
    float a = random(i);
    float b = random(i + vec2(1.0, 0.0));
    float c = random(i + vec2(0.0, 1.0));
    float d = random(i + vec2(1.0, 1.0));
    
    vec2 u = f*f*(3.0-2.0*f);
    return mix(a, b, u.x) +
    (c - a)* u.y * (1.0 - u.x) +
    (d - b) * u.x * u.y;
}

vec4 blur13(sampler2D image, vec2 st, vec2 direction) {
    vec4 color = vec4(0.0);
    vec2 off1 = vec2(1.411764705882353) * direction;
    vec2 off2 = vec2(3.2941176470588234) * direction;
    vec2 off3 = vec2(5.176470588235294) * direction;
    color += texture(image, st) * 0.1964825501511404;
    color += texture(image, st + (off1)) * 0.2969069646728344;
    color += texture(image, st - (off1)) * 0.2969069646728344;
    color += texture(image, st + (off2)) * 0.09447039785044732;
    color += texture(image, st - (off2)) * 0.09447039785044732;
    color += texture(image, st + (off3)) * 0.010381362401148057;
    color += texture(image, st - (off3)) * 0.010381362401148057;
    return color;
}

void main(void){
    
    vec2 st = vertTexCoord.xy;
    //st.x = st.x+cos(st.y*40.0+time*30.0)*0.001;
    //st.y = st.y+cos(st.x*40.0+time)*0.001;
    
    vec4 col = texture(texture, st);
    
    
    
    vec2 nd = direction;//*noise(vertTexCoord.xy*0.1+vec2(0.0, time));
    
    float r = blur13(texture, st, nd).r;
    float g = blur13(texture, st, nd*0.5).g;
    float b = blur13(texture, st, nd*2.21).b;
    
    gl_FragColor = vec4(r, g, b, 1.0) * 1.0001 * vertColor;

}
