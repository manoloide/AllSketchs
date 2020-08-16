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

void main(void) {
    vec2 st = gl_FragCoord.xy/resolution.xy;
    
    bool mirrorV = true;
    if(mirrorV){
        st.y = abs(st.y-0.5);
        st.y += 0.5;
    }
    
    bool mirrorH = true;
    if(mirrorH){
        st.x = abs(st.x-0.5);
        st.x += 0.5;
    }
    
	vec4 col = texture2D(texture, st);
	gl_FragColor = vec4(vec3(col.rgb), 1.0);

}
