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

void main() {

	vec4 col = texture2D(texture, vertTexCoord.st);

	col *= (0.99+cos((vertTexCoord.y+iGlobalTime*0.004)*iResolution.y*2.3)*0.02);
	col = mix(col, vec4(0.0, 0.0, 0.0, 1.0), pow(distance(vertTexCoord.st, vec2(0.5, 0.5)), 2.2));


	gl_FragColor = vec4(col.rgb, 1.0);

}
