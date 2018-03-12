#define PROCESSING_COLOR_SHADER

uniform sampler2D texture;
uniform vec2 texOffset;

varying vec4 vertColor;
varying vec4 vertTexCoord;

uniform vec2 resolution;
void main() {
   float intw = abs(gl_FragCoord.x/resolution.x-0.5);
   float inth = abs(gl_FragCoord.y/resolution.y-0.5);
   float intensidad = 1-(inth*intw)*1;
   //if(mod(gl_FragCoord.y, 2) == 1) intensidad = 0.1;
   vec4 col = texture2D(texture, vertTexCoord.st);
   gl_FragColor = vec4(col.r*intensidad, col.g*intensidad, col.b*intensidad, 1.0);

}
