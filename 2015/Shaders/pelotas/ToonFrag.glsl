#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

#define PROCESSING_LIGHT_SHADER

uniform float fraction;

varying vec4 vertColor;
varying vec3 vertNormal;
varying vec3 vertLightDir;

void main() {  
  float intensity;
  vec4 color;
  intensity = max(0.0, dot(vertLightDir, vertNormal));

  intensity = pow(intensity, 1.5);

  color = vec4(vec3(intensity), 1.0);

  float aux = intensity/pow(0.95, fraction);
  if (aux > 1.0) {
    color = vec4(vec3(intensity*pow(aux, 120)), 1.0);
  } 
  else {
    aux = intensity/pow(0.1, fraction);
    if (aux < 0.1) {
      color = vec4(vec3(0.03-aux), 1.0);
    }
  }

  gl_FragColor = vertColor * color;  
}