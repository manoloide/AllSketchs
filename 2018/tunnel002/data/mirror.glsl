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

float rand(vec2 co){
    return fract(sin(dot(co.xy ,vec2(12.9898,78.233))) * 43758.5453);
}

void main(void) {
    vec2 st = gl_FragCoord.xy/resolution.xy;
    
    st -= 0.5;
    st *= (0.4+cos(time*2.0)*0.4+0.4)*2.0;
    //st *= 2.0;
    //st = fract(st);
    st += 0.5;

    
    float sel = floor(mod(time, 0.02));

    float x1 = 0.5-abs(0.5-st.x);
    float x2 = 0.5+abs(0.5-st.x);

    float y1 = 0.5-abs(0.5-st.y);
    float y2 = 0.5+abs(0.5-st.y);

    vec2 i1, i2;
    if(sel == 0.0){
    	i1 = vec2(x1, y1);
    	i2 = vec2(x2, y1);
    }

    if(sel == 1.0){
    	i1 = vec2(x2, y1);
    	i2 = vec2(x2, y2);
    }

    if(sel == 2.0){
    	i1 = vec2(x2, y2);
    	i2 = vec2(x1, y2);
    }

    if(sel == 3.0){
    	i1 = vec2(x1, y2);
    	i2 = vec2(x1, y1);
    }
    
	vec3 c1 = texture2D(texture, i1).rgb;
	vec3 c2 = texture2D(texture, i2).rgb;

	float tt = pow(fract(time), 1.0);
    vec3 col = c2;//mix(c1, c2, tt);
	
	//col = texture2D(texture, st).rgb;

	float dd = distance(vec2(0.5), st);
	col *= pow((1.0-dd*0.2), 1.2);
	col = col*0.9+(col*col)*0.5;
	col = mix(col, vec3(rand(st+time*0.0001)), 0.04);

	col.r = pow(col.r, 1.1);
	col.g = pow(col.g, 1.0);
	col.b = pow(col.b, 1.0);
	gl_FragColor = vec4(vec3(col.rgb), 1.0);

}
