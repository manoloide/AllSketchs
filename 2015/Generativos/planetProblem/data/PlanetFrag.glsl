#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

/*
uniform sampler2D texture;
uniform sampler2D normalMap;
*/
uniform vec2 texOffset;

varying vec4 vertColor;
varying vec4 backVertColor;
varying vec4 vertTexCoord;

void main() {
  
	//vec4 col = texture2D(texture, vertTexCoord.st) * vertColor;

	gl_FragColor = vertColor;

	// por las dudas
	//gl_FragColor = gl_FrontFacing ? texture2D(texture, vertTexCoord.st) * vertColor : backVertColor;
}