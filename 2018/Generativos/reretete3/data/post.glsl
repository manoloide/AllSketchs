#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

#define PROCESSING_TEXTURE_SHADER

uniform sampler2D texture;
uniform vec2 texOffset;

varying vec4 vertColor;
varying vec4 vertTexCoord;

float rand(vec2 n) {
    return fract(sin(dot(n, vec2(12.9898, 4.1414))) * 43758.5453);
}

vec3 csb(vec3 color, float brt, float sat, float con) {
    const float AvgLumR = 0.5;
    const float AvgLumG = 0.5;
    const float AvgLumB = 0.5;
    const vec3 LumCoeff = vec3(0.2125, 0.7154, 0.0721);
    vec3 AvgLumin  = vec3(AvgLumR, AvgLumG, AvgLumB);
    vec3 brtColor  = color * brt;
    vec3 intensity = vec3(dot(brtColor, LumCoeff));
    vec3 satColor  = mix(intensity, brtColor, sat);
    vec3 conColor  = mix(AvgLumin, satColor, con);
    
    return conColor;
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
    
    return (1.0 * col0 + 2.0 * col1 + 1.0 * col2 +
            2.0 * col3 + 4.0 * col4 + 2.0 * col5 +
            1.0 * col6 + 2.0 * col7 + 1.0 * col8) / 16.0;
}

void main(void) {
    
    vec2 st = vertTexCoord.st;
    vec3 col = texture2D(texture, st).rgb;

    vec3 sum = col;//mix(col, blur(), 0.9);
    
    float dis = 1.0-pow(clamp(distance(st, vec2(0.5)), 0.0, 1.0), 2.4)*0.5;

    sum = mix(sum, vec3(rand(st*200)), 0.02);
    sum = csb(sum, 1.4, 1.2+(1.0-dis)*2.6, 1.9)*dis;
    
    sum.r = pow(sum.r, 1.0);
    sum.g = pow(sum.g, 0.98);
    sum.b = pow(sum.b, 1.0);

    gl_FragColor = vec4(sum.rgb, 1.0) * vertColor;
}
