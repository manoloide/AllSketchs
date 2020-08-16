#ifdef GL_ES
precision highp float;
precision mediump int;
#endif

#define PROCESSING_TEXTURE_SHADER

uniform sampler2D texture;
uniform vec2 texOffset;
uniform vec2 direction;
uniform float time;

varying vec4 vertColor;
varying vec4 vertTexCoord;

// Simplex 2D noise
//
vec3 permute(vec3 x) { return mod(((x*34.0)+1.0)*x, 289.0); }

float snoise(vec2 v){
    const vec4 C = vec4(0.211324865405187, 0.366025403784439,
                        -0.577350269189626, 0.024390243902439);
    vec2 i  = floor(v + dot(v, C.yy) );
    vec2 x0 = v -   i + dot(i, C.xx);
    vec2 i1;
    i1 = (x0.x > x0.y) ? vec2(1.0, 0.0) : vec2(0.0, 1.0);
    vec4 x12 = x0.xyxy + C.xxzz;
    x12.xy -= i1;
    i = mod(i, 289.0);
    vec3 p = permute( permute( i.y + vec3(0.0, i1.y, 1.0 ))
                     + i.x + vec3(0.0, i1.x, 1.0 ));
    vec3 m = max(0.5 - vec3(dot(x0,x0), dot(x12.xy,x12.xy),
                            dot(x12.zw,x12.zw)), 0.0);
    m = m*m ;
    m = m*m ;
    vec3 x = 2.0 * fract(p * C.www) - 1.0;
    vec3 h = abs(x) - 0.5;
    vec3 ox = floor(x + 0.5);
    vec3 a0 = x - ox;
    m *= 1.79284291400159 - 0.85373472095314 * ( a0*a0 + h*h );
    vec3 g;
    g.x  = a0.x  * x0.x  + h.x  * x0.y;
    g.yz = a0.yz * x12.xz + h.yz * x12.yw;
    return 130.0 * dot(m, g);
}
//    Simplex 3D Noise
//    by Ian McEwan, Ashima Arts
//
vec4 permute(vec4 x){return mod(((x*34.0)+1.0)*x, 289.0);}
vec4 taylorInvSqrt(vec4 r){return 1.79284291400159 - 0.85373472095314 * r;}

float snoise(vec3 v){
    const vec2  C = vec2(1.0/6.0, 1.0/3.0) ;
    const vec4  D = vec4(0.0, 0.5, 1.0, 2.0);
    
    // First corner
    vec3 i  = floor(v + dot(v, C.yyy) );
    vec3 x0 =   v - i + dot(i, C.xxx) ;
    
    // Other corners
    vec3 g = step(x0.yzx, x0.xyz);
    vec3 l = 1.0 - g;
    vec3 i1 = min( g.xyz, l.zxy );
    vec3 i2 = max( g.xyz, l.zxy );
    
    //  x0 = x0 - 0. + 0.0 * C
    vec3 x1 = x0 - i1 + 1.0 * C.xxx;
    vec3 x2 = x0 - i2 + 2.0 * C.xxx;
    vec3 x3 = x0 - 1. + 3.0 * C.xxx;
    
    // Permutations
    i = mod(i, 289.0 );
    vec4 p = permute( permute( permute(
                                       i.z + vec4(0.0, i1.z, i2.z, 1.0 ))
                              + i.y + vec4(0.0, i1.y, i2.y, 1.0 ))
                     + i.x + vec4(0.0, i1.x, i2.x, 1.0 ));
    
    // Gradients
    // ( N*N points uniformly over a square, mapped onto an octahedron.)
    float n_ = 1.0/7.0; // N=7
    vec3  ns = n_ * D.wyz - D.xzx;
    
    vec4 j = p - 49.0 * floor(p * ns.z *ns.z);  //  mod(p,N*N)
    
    vec4 x_ = floor(j * ns.z);
    vec4 y_ = floor(j - 7.0 * x_ );    // mod(j,N)
    
    vec4 x = x_ *ns.x + ns.yyyy;
    vec4 y = y_ *ns.x + ns.yyyy;
    vec4 h = 1.0 - abs(x) - abs(y);
    
    vec4 b0 = vec4( x.xy, y.xy );
    vec4 b1 = vec4( x.zw, y.zw );
    
    vec4 s0 = floor(b0)*2.0 + 1.0;
    vec4 s1 = floor(b1)*2.0 + 1.0;
    vec4 sh = -step(h, vec4(0.0));
    
    vec4 a0 = b0.xzyw + s0.xzyw*sh.xxyy ;
    vec4 a1 = b1.xzyw + s1.xzyw*sh.zzww ;
    
    vec3 p0 = vec3(a0.xy,h.x);
    vec3 p1 = vec3(a0.zw,h.y);
    vec3 p2 = vec3(a1.xy,h.z);
    vec3 p3 = vec3(a1.zw,h.w);
    
    //Normalise gradients
    vec4 norm = taylorInvSqrt(vec4(dot(p0,p0), dot(p1,p1), dot(p2, p2), dot(p3,p3)));
    p0 *= norm.x;
    p1 *= norm.y;
    p2 *= norm.z;
    p3 *= norm.w;
    
    // Mix final noise value
    vec4 m = max(0.6 - vec4(dot(x0,x0), dot(x1,x1), dot(x2,x2), dot(x3,x3)), 0.0);
    m = m * m;
    return 42.0 * dot( m*m, vec4( dot(p0,x0), dot(p1,x1),
                                 dot(p2,x2), dot(p3,x3) ) );
}

// 2D Random
float random (in vec2 st) {
    return fract(sin(dot(st.xy,vec2(12.9898,78.233)))*43758.5453123);
}

// 2D Noise based on Morgan McGuire @morgan3d
// https://www.shadertoy.com/view/4dS3Wd
float noise (in vec2 st) {
    vec2 i = floor(st);
    vec2 f = fract(st);
    
    float a = random(i);
    float b = random(i + vec2(1.0, 0.0));
    float c = random(i + vec2(0.0, 1.0));
    float d = random(i + vec2(1.0, 1.0));
    
    vec2 u = f*f*(3.0-2.0*f);
    return mix(a, b, u.x) +
    (c - a)* u.y * (1.0 - u.x) +
    (d - b) * u.x * u.y;
}

vec4 blur13(sampler2D image, vec2 st, vec2 direction) {
    vec4 color = vec4(0.0);
    vec2 off1 = vec2(1.411764705882353) * direction;
    vec2 off2 = vec2(3.2941176470588234) * direction;
    vec2 off3 = vec2(5.176470588235294) * direction;
    color += texture(image, st) * 0.1964825501511404;
    color += texture(image, st + (off1)) * 0.2969069646728344;
    color += texture(image, st - (off1)) * 0.2969069646728344;
    color += texture(image, st + (off2)) * 0.09447039785044732;
    color += texture(image, st - (off2)) * 0.09447039785044732;
    color += texture(image, st + (off3)) * 0.010381362401148057;
    color += texture(image, st - (off3)) * 0.010381362401148057;
    return color;
}

void main(void){
    
    vec2 st = (vertTexCoord.xy-0.5);//*(0.98+cos(time*0.002)*0.2);//*(1.0+cos(time)*0.001);
    st *= (1.0+cos(time*5.0)*0.001);
    st += 0.5;
    
    float ang = (snoise(vec3(st.x*2.0, st.y*1.2, time*4.0))*2.0-1.0)*asin(1.0)*6.0;
    float dis = 0.6;//pow((noise(vec2(st.y+cos(st.x*1.0+time*0.2), time*0.009))*2.0-1.0), 2.0)*20.0;
    st.x += cos(ang)*dis*0.01;
    st.y += sin(ang)*dis*0.01;
    
    st.x += cos(time*0.01)*0.0002;
    //st.x += cos(st.y*80.0+time*8.0)*0.0005;
    
    //st += time*1000.0;
    
    vec4 col = texture(texture, st);
    
    
    
    vec2 nd = direction*noise(st*6.0+time*30.0)*0.1;//1.0;//*noise(vertTexCoord.xy*0.1+vec2(0.0, time));
    
    float r = blur13(texture, st, nd*3.1).r;//*1.00001;
    float g = blur13(texture, st, nd*4.1).g;
    float b = pow(blur13(texture, st, nd*5.91).b, 1.001);
    
    /*
    r = col.r;
    g = col.g;
    b = col.b;
     */
    
    gl_FragColor = vec4(r, g, b, 1.0) * 1.002 * vertColor;

}
