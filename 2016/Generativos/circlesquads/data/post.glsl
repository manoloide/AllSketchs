#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif


#define PROCESSING_TEXTURE_SHADER
uniform sampler2D texture;
uniform sampler2D displace;
uniform vec2 texOffset;

varying vec4 vertColor;
varying vec4 vertTexCoord;

uniform vec2 resolution;
uniform float time;

float rand(float n) {
	return fract(sin(n) * 43758.5453123);
}

vec2 barrelDistortion(vec2 coord, float amt) {
	vec2 cc = coord - 0.5;
	float dist = dot(cc, cc);
	return coord + cc * dist * amt;
}

float sat( float t ){
	return clamp( t, 0.0, 1.0 );
}

float linterp( float t ) {
	return sat( 1.0 - abs( 2.0*t - 1.0 ) );
}

float remap( float t, float a, float b ) {
	return sat( (t - a) / (b - a) );
}

vec3 spectrum_offset( float t ) {
	vec3 ret;
	float lo = step(t,0.5);
	float hi = 1.0-lo;
	float w = linterp( remap( t, 1.0/6.0, 5.0/6.0 ) );
	ret = vec3(lo,1.0,hi) * vec3(1.0-w, w, 1.0-w);

	return pow( ret, vec3(1.0/2.2) );
}

const int num_iter = 12;
const float reci_num_iter_f = 1.0 / float(num_iter);


const float chroma = 0.005;

vec3 pickColor( vec2 _pos ){
    vec3 color = texture2D( texture, _pos ).rgb;
    return color;
}


vec3 saturation(vec3 rgb, float adjustment)
{
    // Algorithm from Chapter 16 of OpenGL Shading Language
    const vec3 W = vec3(0.2125, 0.7154, 0.0721);
    vec3 intensity = vec3(dot(rgb, W));
    return mix(intensity, rgb, adjustment);
}

vec3 saturate(vec3 color, float amount)
{
    vec3 gray = vec3(dot(vec3(0.2126,0.7152,0.0722), color));
    return vec3(mix(color, gray, amount));
}

void main(void) {
	vec2 uv = gl_FragCoord.xy/resolution.xy;
	vec3 col = texture2D(texture, uv).rgb;
	float dist = distance(uv, vec2(0.5, 0.5));

	/*
	vec3 sumcol = vec3(0.0);
	vec3 sumw = vec3(0.0);    

	for(int i = 0; i < num_iter; ++i){
		float t = float(i)*reci_num_iter_f;
		vec3 w = spectrum_offset(t);
		sumw += w;
		sumcol += w*pickColor(barrelDistortion(uv, chroma*t));
	}
	col = sumcol.rgb/sumw;
	*/
	
	
	float n = rand(uv.x*30.43+uv.y*70.7+time*0.02)*0.5;
	col = mix(col, vec3(pow(n, 0.6)), 0.07);
	//col = mix(col, vec3(1.0-dist), 0.05+pow(dist, 2.8)*0.8);

	col = saturate(col, -0.2);

	gl_FragColor = vec4(vec3(col.rgb), 1.0);

}
