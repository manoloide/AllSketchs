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
	float amp = 12.0;

	vec2 uv = gl_FragCoord.xy / resolution.xy;
	vec4 col = texture2D(texture, uv);

	float dist = distance(uv, vec2(0.5, 0.5))*2.0;
	dist = pow(dist, 1.8);
	int cc = int(dist*amp);
	cc = max(0, cc);

	float div = 1;

	for(int yy = -cc; yy <= cc; yy++){
		for(int xx = -cc; xx <= cc; xx++){
			float dd = distance(vec2(xx, yy), vec2(0, 0))/amp;
			if(xx == 0 && yy == 0) dd = 1;
			col += texture2D(texture, (gl_FragCoord.xy+vec2(xx, yy)) / resolution.xy) * dd;
			div += dd;
		}
	}

	col /= div;


	gl_FragColor = vec4(col.rgb, 1.0);

}