uniform sampler2D tex0;
uniform sampler2D tex1;
uniform float mixValue;

varying vec4 vertTexCoord;

void main(void) {
	vec2 p = vertTexCoord.xy; // put texture coordinates in vec2 p for convenience
	
	vec4 col0 = texture2D(tex0, p); // color of texture 0
	vec4 col1 = texture2D(tex1, p); // color of texture 1
	
	vec4 colorFinal;

	colorFinal = mix(col0, col1, mixValue);
	
	gl_FragColor = colorFinal;
}
