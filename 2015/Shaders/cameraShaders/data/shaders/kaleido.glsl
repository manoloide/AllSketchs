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

void main(void)
{
	vec2 center = vec2(0.5, 0.5);
	int cc = 12;
	float angle = time*2.4;
	float da = TWO_PI/cc;
	bool esp = true;

	vec2 uv = gl_FragCoord.xy / resolution.xy;
	float a = atan(center.y-uv.y, center.x-uv.x)+TWO_PI; 
	float am = mod(a, da);
	if(esp && mod(a, da*2) > da) am = da-am;
	am += angle;
	float d = distance(center, uv);

	uv = center+vec2(cos(am), sin(am))*d;
	vec4 col = texture2D(texture, uv);

	gl_FragColor = vec4(col.rgb, 1.0);

}