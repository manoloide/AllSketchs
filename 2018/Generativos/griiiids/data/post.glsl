#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

#define PROCESSING_TEXTURE_SHADER

uniform sampler2D texture;
uniform vec2 texOffset;

varying vec4 vertColor;
varying vec4 vertTexCoord;

float rand(float n){return fract(sin(n) * 43758.5453123);}

float rand(vec2 n) {
    return fract(sin(dot(n, vec2(12.9898, 4.1414))) * 43758.5453);
}

float noise(float p){
    float fl = floor(p);
    float fc = fract(p);
    return mix(rand(fl), rand(fl + 1.0), fc);
}

float noise(vec2 n) {
    const vec2 d = vec2(0.0, 1.0);
    vec2 b = floor(n), f = smoothstep(vec2(0.0), vec2(1.0), fract(n));
    return mix(mix(rand(b), rand(b + d.yx), f.x), mix(rand(b + d.xy), rand(b + d.yy), f.x), f.y);
}

vec3 blur(){
    
    vec2 tc0 = vertTexCoord.st + vec2(-texOffset.s, -texOffset.t);
    vec2 tc1 = vertTexCoord.st + vec2(         0.0, -texOffset.t);
    vec2 tc2 = vertTexCoord.st + vec2(+texOffset.s, -texOffset.t);
    vec2 tc3 = vertTexCoord.st + vec2(-texOffset.s,          0.0);
    vec2 tc4 = vertTexCoord.st + vec2(         0.0,          0.0);
    vec2 tc5 = vertTexCoord.st + vec2(+texOffset.s,          0.0);
    vec2 tc6 = vertTexCoord.st + vec2(-texOffset.s, +texOffset.t);
    vec2 tc7 = vertTexCoord.st + vec2(         0.0, +texOffset.t);
    vec2 tc8 = vertTexCoord.st + vec2(+texOffset.s, +texOffset.t);
    
    vec3 col0 = texture2D(texture, tc0).rgb;
    vec3 col1 = texture2D(texture, tc1).rgb;
    vec3 col2 = texture2D(texture, tc2).rgb;
    vec3 col3 = texture2D(texture, tc3).rgb;
    vec3 col4 = texture2D(texture, tc4).rgb;
    vec3 col5 = texture2D(texture, tc5).rgb;
    vec3 col6 = texture2D(texture, tc6).rgb;
    vec3 col7 = texture2D(texture, tc7).rgb;
    vec3 col8 = texture2D(texture, tc8).rgb;
    
    vec3 sum = (1.0 * col0 + 2.0 * col1 + 1.0 * col2 +
                2.0 * col3 + 4.0 * col4 + 2.0 * col5 +
                1.0 * col6 + 2.0 * col7 + 1.0 * col8) / 16.0;
    
    return sum;
}

vec3 saturate(vec3 col, float amt){
    col.r = clamp(col.r*amt, 0.0, 1.0);
    col.g = clamp(col.g*amt, 0.0, 1.0);
    col.b = clamp(col.b*amt, 0.0, 1.0);
    return col;
}

void main(void) {
    
    vec2 st = vertTexCoord.st;
    vec3 col = texture2D(texture, st).rgb;
    
    vec3 sum = blur();
    
    sum = mix(col, sum, 0.8);

    float dis = min(1, pow(distance(st, vec2(0.5))*1.3, 3.0));
    sum = mix(sum, vec3(0.0), dis*0.5);
    sum *= sum*(1-pow(rand(st*100.0), 2.0)*0.1);
    
    sum.r = pow(sum.r, 0.86);
    sum.g = pow(sum.g, 1.02);
    sum.b = pow(sum.b, 1.05);
    
    sum = saturate(sum, 1.2 + dis*1.4);
    
    gl_FragColor = vec4(sum.rgb, 1.0) * vertColor;
}
