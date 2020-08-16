#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif


#define PROCESSING_TEXTURE_SHADER
uniform sampler2D texture;
uniform vec2 texOffset;

uniform float chroma;

varying vec4 vertColor;
varying vec4 vertTexCoord;

uniform vec2 resolution;
uniform float time;

float rand(float n) {
	return fract(sin(n) * 43758.5453123);
}

vec2 barrelDistortion(vec2 coord, float amt) {
    vec2 cc = coord-0.5;
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

vec4 spectrum_offset( float t ) {
    vec4 ret;
    float lo = step(t,0.5);
    float hi = 1.0-lo;
    float w = linterp( remap( t, 1.0/6.0, 5.0/6.0 ) );
    ret = vec4(lo,1.0,hi, 1.) * vec4(1.0-w, w, 1.0-w, 1.);
    return pow( ret, vec4(1.0/2.2) );
}

const float max_distort = 1.2;
const int num_iter = 12;
const float reci_num_iter_f = 1.0 / float(num_iter);

void main(void) {
    vec2 st = gl_FragCoord.xy/resolution.xy;
    
	vec4 col = texture2D(texture, st);
	float dist = distance(st, vec2(0.5, 0.5));
    
    vec4 sumcol = vec4(0.0);
    vec4 sumw = vec4(0.0);
    float maxchroma = max_distort*0.02;
    for (int i = 0; i < num_iter; ++i) {
        float t = float(i) * reci_num_iter_f;
        vec4 w = spectrum_offset(t);
        sumw += w;
        sumcol += w * texture2D(texture, barrelDistortion(st, maxchroma*t));
    }
    col = sumcol/sumw;

	col *= (0.9998+cos((st.y*1.9-time*0.0075)*resolution.y*1.8)*0.002);

	float n = rand(st.x*30.43+st.y*70.7+time*0.02)*0.5;
	col = mix(col, vec4(n), 0.01);
	col = mix(col, vec4(0.0, 0.0, 0.0, 1.0), pow(dist, 1.2)*0.05);

	gl_FragColor = vec4(vec3(col.rgb), 1.0);

}
