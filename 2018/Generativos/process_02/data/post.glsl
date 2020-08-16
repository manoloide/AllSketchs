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

void main(void) {
    
    vec2 st = vertTexCoord.st;
    vec3 col = texture2D(texture, st).rgb;
    float luma = col.r*0.2126+col.g*0.7152+col.b*0.0722;
    vec3 sum = col;
    
    float dis = 1.0-pow(clamp(distance(st, vec2(0.5)), 0.0, 1.0), 2.4)*0.5;

    sum = mix(sum, vec3(luma+rand(st*200)*0.4-0.2), 0.12*(1-luma));
    sum = csb(sum, 1.1+luma*0.05, 1.2+(1.0-dis)*2.6, 1.0)*dis;
    
    sum.r = pow(sum.r, 1.0);
    sum.g = pow(sum.g, 0.95);
    sum.b = pow(sum.b, 1.0);

    gl_FragColor = vec4(sum.rgb, 1.0) * vertColor;
}
