#ifdef GL_ES
precision highp float;
precision highp int;
#endif

#define PROCESSING_TEXTURE_SHADER

uniform sampler2D texture;
uniform vec2 texOffset;

uniform float width;
uniform float height;
uniform int seed;
uniform vec2 areaWidth;
uniform vec2 areaHeight;
uniform int iterations;
uniform float time;

varying vec4 vertColor;
varying vec4 vertTexCoord;

//float a[5] = float[](3.4, 4.2, 5.0, 5.2, 1.1);
const vec3 color_map[17] = vec3[](
    vec3(0.18, 0.18, 0.99),
    vec3(0.84, 0.33, 0.08),
    vec3(0.11, 0.82, 0.26),
    vec3(0.04, 0.0,  0.18),
    vec3(0.02, 0.02, 0.29),
    vec3(0.0,  0.03, 0.39),
    vec3(0.05, 0.17, 0.54),
    vec3(0.09, 0.32, 0.69),
    vec3(0.22, 0.49, 0.82),
    vec3(0.52, 0.71, 0.9),
    vec3(0.82, 0.92, 0.97),
    vec3(0.94, 0.91, 0.75),
    vec3(0.98, 0.52, 0.65),
    vec3(1.0, 0.0, 0.42),
    vec3(0.96, 0.4, 0.19),
    vec3(0.13, 0.27, 0.22),
    vec3(0.21, 0.3, 0.89)
);

void main(void) {

    vec2 C = vec2(vertTexCoord.x*(areaWidth.y-areaWidth.x)+areaWidth.x, vertTexCoord.y*(areaHeight.y-areaHeight.x)+areaHeight.x);
    //C.x *= width*1.0/height;
    
    vec2 Z = vec2(0.0);
    int iteration = 0;

    while (iteration < iterations) {
        float x = Z.x*Z.x-Z.y*Z.y+C.x;
        float y = 2*Z.x*Z.y+C.y;

        if (x*x+y*y > mod(seed*0.2, 80.0)){
            break;
        }
        Z.x = x;
        Z.y = y;
        ++iteration;
    }


    int row_index = (iteration*100/iterations%17);
    vec3 color = (iteration == iterations ? vec3(0.0) : color_map[row_index]);
    //vec3 color = vec3(cos(row_index*time), cos(row_index*0.995*time*0.1), cos(row_index*1.002*time));
    /* añadir patrones por color
    if(row_index == 0) {
        
    }
     */
    
    
    gl_FragColor = vec4(color.rgb, 1.0);

}
