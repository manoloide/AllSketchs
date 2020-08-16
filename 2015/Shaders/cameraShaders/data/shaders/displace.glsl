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

void main(void)
{
	vec2 uv = gl_FragCoord.xy / resolution.xy;
	//vec4 col = texture2D(texture, uv);
	float r = texture2D(texture, uv+vec2(0.024*cos(time*5+3), 0.09*cos(time*8.3+4))).r;
	float g = texture2D(texture, uv+vec2(0.01*cos(time*5+4), 0.07*cos(time*2.3))).g;
	float b = texture2D(texture, uv+vec2(0.1*cos(time*5+2), 0.02*cos(time*4.3+6))).b;

	vec4 col = vec4(r, g, b, 1.0);

	gl_FragColor = vec4(col.rgb, 1.0);

}