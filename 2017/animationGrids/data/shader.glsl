
#define PROCESSING_TEXTURE_SHADER

uniform sampler2D texture;
uniform sampler2D displace;
uniform vec2 resolution;
uniform vec2 textureResolution;
uniform float chroma;
uniform float grain;

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

const int num_iter = 24;
const float reci_num_iter_f = 1.0 / float(num_iter);

vec3 pickColor( vec2 _pos ){
    vec3 color = texture2D( texture, _pos ).rgb;

    if (grain>0.0){
        vec3 disp = texture2D(displace, _pos).rgb;
        _pos.x += disp.x*grain;
        _pos.x += disp.y*grain;

        color *= 0.1;
        color += texture2D( texture, _pos).rgb *0.9;

    }

    return color;
}

void main(){
    vec2 st = gl_FragCoord.xy/resolution.xy;

    vec3 sumcol = vec3(0.0);
    vec3 sumw = vec3(0.0);    

    if ( chroma != 0.0 ){
        for ( int i=0; i<num_iter;++i ){
            float t = float(i) * reci_num_iter_f;
            vec3 w = spectrum_offset( t );
            sumw += w;
            sumcol += w * pickColor( barrelDistortion(st, chroma*t) );
        }
        gl_FragColor = vec4(sumcol.rgb / sumw, 1.0);
    } else {
        gl_FragColor = vec4( pickColor( st ), 1.0); 
    }
}
