#version 150

uniform sampler2DRect tex0;
uniform vec2 resolution;
uniform float chroma;

in vec2 texCoordVarying;
out vec4 outputColor;

vec2 barrelDistortion(vec2 coord, float amt) {
    vec2 cc = coord-0.5;
    float dist = dot(cc, cc);
    return coord + cc * dist * amt;
}

float sat( float t )
{
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

const float max_distort = 2.2;
const int num_iter = 24;
const float reci_num_iter_f = 1.0 / float(num_iter);

void main() {
    vec2 st = texCoordVarying/resolution;
    
    vec4 sumcol = vec4(0.0);
    vec4 sumw = vec4(0.0);
    float maxchroma = 0.5*chroma*max_distort;
    for (int i = 0; i < num_iter; ++i) {
        float t = float(i) * reci_num_iter_f;
        vec4 w = spectrum_offset( t );
        sumw += w;
        sumcol += w * texture( tex0, barrelDistortion(st, maxchroma*t )*resolution);
    }
    
    outputColor = sumcol / sumw;
}
