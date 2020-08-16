#define PROCESSING_LINE_SHADER

varying vec4 vertColor;

uniform vec3 fogColor;
uniform float fogNear;
uniform float fogFar;

void main(){
    gl_FragColor = vertColor;
    float depth = gl_FragCoord.z / gl_FragCoord.w;
    float fogFactor = smoothstep(fogNear, fogFar, depth);
    gl_FragColor = vec4(mix(gl_FragColor.rgb, fogColor.rgb, fogFactor), vertColor.a);
}
