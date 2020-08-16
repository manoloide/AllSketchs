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

void main(void){
	vec2 uv = (gl_FragCoord.xy / resolution.xy)*0.5;

	//if(uv.x > 0.5) uv.x = uv.x-1.0;
	//if(uv.y > 0.5) uv.y = uv.y-1.0;
	if(uv.x > 0.5) uv.x = 1.0-uv.x;
	if(uv.y < 0.5) uv.y = 1.0-uv.y;
	vec4 ori = texture2D(texture, uv);

	//col = mix(col, vec4(0.0, 0.0, 0.0, 1.0), rand(uv+time)*0.3);
	//col *= (0.99+cos((uv.y+time*0.006)*resolution.y*1.8)*0.04);
	//col = mix(col, vec4(0.0, 0.0, 0.0, 1.0), pow(distance(uv, vec2(0.5, 0.5)), 1));

	gl_FragColor = ori;

}