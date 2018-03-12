#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif


#define PROCESSING_TEXTURE_SHADER
uniform sampler2D texture;
uniform vec2 texOffset;

varying vec4 vertColor;
varying vec4 vertTexCoord;

uniform vec2 resolution;
uniform float time;

void main(void) {
    vec2 st = gl_FragCoord.xy/resolution.xy;
	vec3 col = texture2D(texture, st).rgb;
    
    col.b *= 1.02;
    col.r *= 1.05;
    col.b *= 0.99;
    
    col *= 0.9+col*0.2;
    float pwr = 1.2;
    col = vec3(pow(col.r, pwr), pow(col.g, pwr), pow(col.b, pwr));
	gl_FragColor = vec4(vec3(col.rgb), 1.0);

}
