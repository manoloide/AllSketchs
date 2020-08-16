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

/*
	float amp = 2.0;

	vec4 blur = texture2D(texture, uv);

	dist = pow(dist, 1.8);
	int cc = int(amp);
	cc = max(0, cc);

	float div = 1.0;

	for(int yy = -cc; yy <= cc; yy++){
		for(int xx = -cc; xx <= cc; xx++){
			//float dd = abs(xx)+abs(yy);
			float dd = distance(vec2(xx, yy), vec2(0.));
			if(xx == 0 && yy == 0) dd = 1.0;
			blur += texture2D(texture, (gl_FragCoord.xy+vec2(xx, yy)) / resolution.xy) * dd;
			div += dd;
		}
	}

	blur /= div;
	//col = col+blur*0.15;
	col = blur;
*/
	col *= (0.995+cos((uv.y*1.9-time*0.025)*resolution.y*1.8)*0.05);

	float intw = abs(gl_FragCoord.x/resolution.x-0.5);
	float inth = abs(gl_FragCoord.y/resolution.y-0.5);

	float n = rand(uv.x*30.43+uv.y*70.7+time*0.02)*0.5;
	col = mix(col, vec4(n), 0.03);
	col = mix(col, vec4(0.0, 0.0, 0.0, 1.0), pow(dist, 1.8));

	gl_FragColor = vec4(vec3(col.rgb), 1.0);

}