#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

#define PROCESSING_TEXTURE_SHADER

uniform sampler2D texture;
uniform vec2 texOffset;

varying vec4 vertColor;
varying vec4 vertTexCoord;
// Brightness threshold.
//uniform float bright_threshold;

void main(){
  float bright_threshold = 0.5;
  vec2 st = vertTexCoord.st;
  vec4 color = texture2D(texture, st);
  
  // Calculate luminance
  float lum = dot(vec4(0.30, 0.59, 0.11, 0.0), color);
  
  // Extract very bright areas of the map.
  if (lum > bright_threshold)
  gl_FragColor = color;
  else
  gl_FragColor = vec4(0.0, 0.0, 0.0, 0.0);
}
