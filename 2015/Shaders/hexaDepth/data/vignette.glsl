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
	vec4 col = texture2D(texture, uv);

	col = mix(col, vec4(0.0), pow(distance(uv, vec2(0.5, 0.5)), 1.2));

	gl_FragColor = vec4(col.rgb, 1.0);

}