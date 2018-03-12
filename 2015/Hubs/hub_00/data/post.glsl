#ifdef GL_ES
precision highp float;
precision highp int;
#endif


#define PROCESSING_TEXTURE_SHADER
uniform sampler2D texture;
uniform vec2 texOffset;

varying vec4 vertColor;
varying vec4 vertTexCoord;

uniform vec2 resolution;
uniform float time;

float rand(vec2 co){
    return fract(sin(dot(co.xy ,vec2(12.9898,78.233))) * 43758.5453);
}

void main(void)
{
	vec2 uv = gl_FragCoord.xy / resolution.xy;
	vec4 ori = texture2D(texture, uv);

	float dis = pow(distance(uv, vec2(0.5, 0.5)), 1.1)*0.24+0.03;
	vec4 col = vec4(texture2D(texture, uv+vec2(0.006*dis, 0.006*dis)).r, texture2D(texture, uv+vec2(-0.001*dis, 0)).g, texture2D(texture, uv+vec2(0, 0.001*dis)).b, 1.0);

	col = mix(col, vec4(0.0, 0.0, 0.0, 1.0), rand(uv+time)*0.3);
	//col *= (0.99+cos((uv.y+time*0.006)*resolution.y*1.8)*0.04);
	col = mix(col, vec4(0.0, 0.0, 0.0, 1.0), pow(distance(uv, vec2(0.5, 0.5)), 1));

	gl_FragColor = vec4(vec3(col.rgb), 1.0);

}