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
	col.r = 1.0;//0.8+0.2*cos(time*0.34441);
	col.g = 0.5;//0.5+0.5*cos(time*0.84342);
	col.b = 0.5+0.5*cos(time*1.23769);
	col.a = 1.;

	col.r = position.x*1.0;
	col.g = position.y;
	col.b = (position.x+position.y)*0.5;
	
	vec2 center;
	float dd = (cos(time*2.0)*0.5+0.5)*0.2;
	center.x = 0.5+cos(time)*dd;
	center.y = 0.5+sin(time*4.0)*dd;
	//center = mouse;
	float dis = distance(position, center);
	if(dis < 0.2){
		col.rgb += sin((dis+0.1)*20.0+time*30.0)*0.4+0.8;
	}
 	center.x = center.x+cos(time*2.4)*0.2;
 	center.y = center.y+sin(time*2.4)*0.2;
	dis = distance(position, center);
	if(dis < (cos(time)*0.02)+0.03){
		col.rgb += (dis+0.1)*2.0;
	}
	center.x = center.x+cos(time*8.4)*0.12;
 	center.y = center.y+sin(time*8.4)*0.12;
	dis = distance(position, center);
	if(dis < 0.02){
		col.rgb += (dis+0.1)*3.0;
	}
	

	if(mod(position.x+cos(time)*0.1, 0.02) < 0.01){
		//col.rgb *= 0.5;
	}

	if(mod(position.x-position.y+time*0.1, 0.1) < 0.05){
		col.rgb *= 0.5;
	}

	if(mod(-position.x+position.y+time*0.1, 0.1) < 0.05){
		col.rgb *= 0.8;
	}

	gl_FragColor = col;
}