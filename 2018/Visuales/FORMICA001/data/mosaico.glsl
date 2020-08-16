#ifdef GL_ES
precision highp float;
precision highp int;
#endif


#define PROCESSING_TEXTURE_SHADER
uniform sampler2D texture;
uniform vec2 texOffset;

varying vec4 vertColor;
varying vec4 vertTexCoord;

uniform vec2 resolution;
uniform float time;

void main(void) {
    vec2 st = gl_FragCoord.xy/resolution.xy;
    vec2 sp = st.xy;
    
    
    //float size = 0.9;
    //float bb = (1.0-size)*0.5;
    
    

	vec3 col = texture(texture, sp).rgb;
    gl_FragColor = vec4(col.rgb, 1.0);
    //gl_FragColor = vec4(vec3(st.x, st.y, 0.0), 1.0); //ESTO ANDA

}
