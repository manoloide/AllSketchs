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
uniform sampler2D tDepth;

float rand(vec2 co){
    return fract(sin(dot(co.xy ,vec2(12.9898,78.233))) * 43758.5453);
}


void main(void)
{
	float amp = 2.0;

	vec2 uv = gl_FragCoord.xy / resolution.xy;
	vec4 col = texture2D(texture, uv);
	vec4 blur = vec4(col);
	
	float depth = 1.0-texture2D(tDepth, vec2(uv.x, 1.0-uv.y)).r;

	int cc = int(depth*amp);
	cc = max(0, cc);
	float div = 1.0;

	cc = 3;

	for(int yy = -cc; yy <= cc; yy++){
		for(int xx = -cc; xx <= cc; xx++){
			float dd = distance(vec2(xx, yy), vec2(0.0, 0.0))/amp;
			if(xx == 0 && yy == 0) dd = 1.0;
			blur += texture2D(texture, (gl_FragCoord.xy+vec2(xx, yy)) / resolution.xy) * dd;
			div += dd;
		}
	}
	

	blur /= div;

	col = col*0.8+blur*0.3;

	col = mix(col, vec4(0.0, 0.0, 0.0, 1.0), rand(uv+time)*0.03);
	col = mix(col, vec4(0.0), pow(distance(uv, vec2(0.5, 0.5)), 1.1)*0.5);

	gl_FragColor = vec4(col.rgb, 1.0);
	//gl_FragColor = vec4(vec3(depth), 1.0);

}
