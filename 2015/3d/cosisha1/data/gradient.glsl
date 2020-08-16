#ifdef GL_ES
precision highp float;
#endif

#define PROCESSING_COLOR_SHADER

uniform float time;
uniform vec2 mouse;
uniform vec2 resolution;
uniform sampler2D pixels;

uniform vec4 col1;
uniform vec4 col2;


void main( void ) {
	vec2 position = ( gl_FragCoord.xy / resolution.xy );
	vec2 pixel = 1./resolution;

	//sum += texture2D(pixels, position + pixel * vec2(-1., -1.)).g;
	float py = position.y;
	float ipy = 1.0-position.y;

	vec4 col = col1*py+col2*ipy;
	
	gl_FragColor = col;
}