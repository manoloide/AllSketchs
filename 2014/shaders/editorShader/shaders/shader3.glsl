#ifdef GL_ES
precision highp float;
#endif

#define PROCESSING_COLOR_SHADER

uniform float time;
uniform vec2 mouse;
uniform vec2 resolution;
uniform sampler2D pixels;


void main( void ) {
	vec2 position = ( gl_FragCoord.xy / resolution.xy );
	vec2 pixel = 1./resolution;

	//sum += texture2D(pixels, position + pixel * vec2(-1., -1.)).g;
	vec4 col; 
	col.r = 0.8+0.2*cos(time*0.34441);
	col.g = 0.5;//0.5+0.5*cos(time*0.84342);
	col.b = 0.5+0.5*cos(time*1.23769);
	col.a = 1.;

	col.rgb = 0;

	if(mod(-position.x+position.y+time*0.1, 0.05) < 0.025){
		col.rgb = 1 -col.rgb;
	}

	gl_FragColor = col;
}