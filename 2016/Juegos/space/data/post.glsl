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

float rand(float n) {
	return fract(sin(n) * 43758.5453123);
}

vec3 saturation(vec3 rgb, float adjustment)
{
    // Algorithm from Chapter 16 of OpenGL Shading Language
    const vec3 W = vec3(0.2125, 0.7154, 0.0721);
    vec3 intensity = vec3(dot(rgb, W));
    return mix(intensity, rgb, adjustment);
}

void main(void) {
	vec2 uv = gl_FragCoord.xy/resolution.xy;
	vec3 col = texture2D(texture, uv).rgb;
	float dist = distance(uv, vec2(0.5, 0.5));
	
	
	float n = rand(uv.x*30.43+uv.y*70.7+time*0.02)*0.5;
	//col = mix(col, vec3(pow(1.0-n, 0.4)), 0.1);
	col = mix(col, vec3(0.0), pow(dist, 4.8)*1.2);

	//col = saturation(col, 1.0+n*0.2);

	gl_FragColor = vec4(vec3(col.rgb), 1.0);

}
