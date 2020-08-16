#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif


#define PROCESSING_TEXTURE_SHADER
uniform sampler2D texture;
uniform vec2 texOffset;

varying vec4 vertColor;
varying vec4 vertTexCoord;

uniform vec2 iResolution;
uniform float iGlobalTime;

void main(void)
{
	vec2 uv = gl_FragCoord.xy / iResolution.xy;
	vec4 ori = texture2D(texture, vec2(1, 1)-uv);


	vec2 tc0 = vertTexCoord.st + vec2(+texOffset.s, 0);
	vec4 col0 = texture2D(texture, tc0);
	vec2 tc1 = vertTexCoord.st + vec2(-texOffset.s, +texOffset.t);
	vec4 col1 = texture2D(texture, tc1);
	vec2 tc2 = vertTexCoord.st + vec2(0, +texOffset.t);
	vec4 col2 = texture2D(texture, tc2);
	vec2 tc3 = vertTexCoord.st + vec2(+texOffset.s, +texOffset.t);
	vec4 col3 = texture2D(texture, tc3);

	vec4 sum = (col0*7.0+col1*3.0+col2*5.0+col3*1.0)/16.0;

	gl_FragColor = vec4(vec3(sum.rgb), 1.0);

}