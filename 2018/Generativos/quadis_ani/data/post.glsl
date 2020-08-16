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

    /*
    float sel = floor(mod(time, 4.0));

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

	float tt = pow(fract(time), 8.0);
	vec3 col = mix(c1, c2, tt);
	*/
	vec3 col = texture2D(texture, st).rgb;

	float dd = distance(vec2(0.5), st);
    col = col*0.6+(col*col)*1.69;
    col *= pow((1.0-dd*0.18), 3.2);
	col = mix(col, vec3(pow(rand(st+time*0.01), 0.2)), 0.05);
    
	col.r = pow(col.r, 1.0);
	col.g = pow(col.g, 1.18);
	col.b = pow(col.b, 1.2);

	gl_FragColor = vec4(vec3(col.rgb), 1.0);

}
