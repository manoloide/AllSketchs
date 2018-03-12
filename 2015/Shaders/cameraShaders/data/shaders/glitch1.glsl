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
uniform vec2 mouse;
uniform float time;

float hash(vec2 p) {
	float h = dot(p,vec2(127.1,311.7));
	return -1.0 + 2.0*fract(sin(h)*43758.5453123);
}

float noise(vec2 p) {
	vec2 i = floor(p);
	vec2 f = fract(p);

	vec2 u = f*f*(3.0-2.0*f);

	return mix(mix(hash( i + vec2(0.0,0.0) ), 
		hash( i + vec2(1.0,0.0) ), u.x),
	mix( hash( i + vec2(0.0,1.0) ), 
		hash( i + vec2(1.0,1.0) ), u.x), u.y);
}

float noise(vec2 p, int oct) {
	mat2 m = mat2( 1.6,  1.2, -1.2,  1.6 );
	float f  = 0;

	for(int i = 1; i < oct; i++){
		float mul = 1/pow(2, i);
		f += mul*noise(p); 
		p = m*p;
	}

	return f;
}

void main(void) {
	vec2 uv = gl_FragCoord.xy / resolution.xy;
	if(noise(time+vec2(0, 0)) > 0.2){
		uv.y = mod(uv.y+noise(vec2(time*4, 0)), 1.0);
	}
	vec2 hp = vec2(0.0, uv.y);
	float nh = noise(hp*7+time*10, 3) * pow(noise(hp+time*0.3)*0.8, 4);
	nh += noise(hp*100+time*10, 3)*0.002;
	vec4 col = texture2D(texture, uv+vec2(nh, 0.0));

	gl_FragColor = vec4(col.rgb, 1.0);

}