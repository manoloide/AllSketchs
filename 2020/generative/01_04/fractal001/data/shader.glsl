#define PROCESSING_COLOR_SHADER

uniform sampler2D grad;
uniform float time;
uniform vec2 resolution;
	
void main( void ) {
    
    vec2 center = vec2(0.2, 0.9);
    float scale = 1.2;
    int iter;
    
	vec2 position = gl_FragCoord.xy / resolution.xy;
    
    vec2 z, c;
    
    c.x = 1.3333 * (position.x - 0.5) * scale - center.x;
    c.y = (position.y - 0.5) * scale - center.y;
    
    int i;
    z = c;
    for(i = 0; i < 100 ; i++) {
        float x = (z.x * z.x - z.y * z.y) + c.x;
        float y = (z.y * z.x + z.x * z.y) + c.y;
        x = mix(x, cos(x*80.2), 0.01);
        //y = sin(y*0.1);
        if((x * x + y * y) > 4.0) break;
        z.x = x;
        z.y = y;
    }
    
	gl_FragColor = vec4(vec3(texture2D(grad, vec2(float(i)/100.0, 0.0))), 1.0);
}
