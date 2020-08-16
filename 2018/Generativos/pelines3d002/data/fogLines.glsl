#define PROCESSING_LINE_SHADER

varying vec4 vertColor;

uniform float fogNear;
uniform float fogFar;

void main(){
    gl_FragColor = vertColor;
    
    vec3 fogColor = vec3(0.0,0.0,0.0);
    float depth = gl_FragCoord.z / gl_FragCoord.w;
    float fogFactor = smoothstep(fogNear, fogFar, depth);
    gl_FragColor = mix(gl_FragColor, vec4(fogColor, gl_FragColor.w), fogFactor);
}
