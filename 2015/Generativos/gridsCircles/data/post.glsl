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
	vec4 ori = texture2D(texture, uv);
	//vec4 col = texture2D(texture, uv);


	float dis = pow(distance(uv, vec2(0.5, 0.5)), 1.1)*0.12+0.06;
	vec4 col = vec4(texture2D(texture, uv+vec2(0.006*dis, 0.006*dis)).r, texture2D(texture, uv+vec2(-0.001*dis, 0)).g, texture2D(texture, uv+vec2(0, 0.001*dis)).b, 1.0);

/*
	vec2 tc0 = vertTexCoord.st + vec2(-texOffset.s, -texOffset.t);
	vec2 tc1 = vertTexCoord.st + vec2(         0.0, -texOffset.t);
	vec2 tc2 = vertTexCoord.st + vec2(+texOffset.s, -texOffset.t);
	vec2 tc3 = vertTexCoord.st + vec2(-texOffset.s,          0.0);
	vec2 tc4 = vertTexCoord.st + vec2(         0.0,          0.0);
	vec2 tc5 = vertTexCoord.st + vec2(+texOffset.s,          0.0);
	vec2 tc6 = vertTexCoord.st + vec2(-texOffset.s, +texOffset.t);
	vec2 tc7 = vertTexCoord.st + vec2(         0.0, +texOffset.t);
	vec2 tc8 = vertTexCoord.st + vec2(+texOffset.s, +texOffset.t);

	vec4 col0 = texture2D(texture, tc0);
	vec4 col1 = texture2D(texture, tc1);
	vec4 col2 = texture2D(texture, tc2);
	vec4 col3 = texture2D(texture, tc3);
	vec4 col4 = texture2D(texture, tc4);
	vec4 col5 = texture2D(texture, tc5);
	vec4 col6 = texture2D(texture, tc6);
	vec4 col7 = texture2D(texture, tc7);
	vec4 col8 = texture2D(texture, tc8);

	vec4 sum = (1.0 * col0 + 2.0 * col1 + 1.0 * col2 +  
		2.0 * col3 + 10.0 * col4 + 2.0 * col5 +
		1.0 * col6 + 2.0 * col7 + 1.0 * col8) / 21.0;

	col = vec4(vec3(col.rgb*0.8 + sum.rgb*0.8), 1.0);
	*/

	col *= (0.99+cos((uv.y+iGlobalTime*0.01)*iResolution.y*1.8)*0.02);

	col = mix(col, vec4(0.0, 0.0, 0.0, 1.0), pow(distance(uv, vec2(0.5, 0.5)), 2.0));

	gl_FragColor = vec4(vec3(col.rgb), 1.0);

}