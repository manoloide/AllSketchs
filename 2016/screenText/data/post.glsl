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

void main(void) {
	vec2 uv = gl_FragCoord.xy/resolution.xy;
	vec4 col = texture2D(texture, uv);
	float dist = distance(uv, vec2(0.5, 0.5));

	//col *= (0.995+cos((uv.y*1.9-time*0.025)*resolution.y*1.8)*0.05);

	float n = rand(uv.x*30.43+uv.y*70.7+time*0.02)*0.5;
	col = mix(col, vec4(n), 0.1);
	col = mix(col, vec4(0.0, 0.0, 0.0, 1.0), pow(dist, 1.8)*0.8);

	vec4 grad = mix(mix(vec4(0.03, 0.04, 0.2, 1.0), vec4(0.13, 0.14, 0.2, 1.0), uv.y), vec4(0.0, 0.0, 0.7, 1.0), uv.x*0.1);

	col = mix(col, grad, cos(time*20)*0.2);
	gl_FragColor = vec4(vec3(col.rgb), 1.0);

}