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
uniform vec2 mouse;
uniform float time;

#define TWO_PI 6.28318530718

void main(void){
	vec2 center = vec2(0.5, 0.5);
	int cc = 5;
	float diag = 0.7;

	vec2 uv = gl_FragCoord.xy / resolution.xy;
	float d = distance(center, uv);

	int tt = int(d/(diag/cc))+4;

	vec4 col1 = texture2D(texture, uv/(pow(tt, 1.2)*0.2));
	vec4 col2 = texture2D(texture, uv/(pow(tt-1, 1.2)*0.2));

	vec4 col = mix(col1, col2, 0.5);

	gl_FragColor = vec4(col.rgb, 1.0);

}
