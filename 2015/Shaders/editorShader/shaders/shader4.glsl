#ifdef GL_ES
precision highp float;
#endif

#define PROCESSING_COLOR_SHADER

uniform float time;
uniform vec2 mouse;
uniform vec2 resolution;
uniform sampler2D pixels;

vec4 ellipse(vec2 p, vec4 col){
	

	return col;
}

void main( void ) {
	vec2 position = ( gl_FragCoord.xy / resolution.xy );
	vec2 pixel = 1./resolution;

	vec4 col = vec4(0.05, 0.05, 0.05, 1);


	
	gl_FragColor = col;
}