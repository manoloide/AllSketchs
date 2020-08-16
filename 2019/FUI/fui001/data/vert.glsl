/*toon
uniform mat4 transform;
uniform mat3 normalMatrix;
uniform vec3 lightNormal;

attribute vec4 vertex;
attribute vec4 color;
attribute vec3 normal;

varying vec4 vertColor;
varying vec3 vertNormal;
varying vec3 vertLightDir;

void main() {
  gl_Position = transform * vertex;  
  vertColor = color;
  vertNormal = normalize(normalMatrix * normal);
  vertLightDir = -lightNormal;
}
*/

#define PROCESSING_LIGHT_SHADER

uniform mat4 modelview;
uniform mat4 transform;
uniform mat3 normalMatrix;

uniform vec4 lightPosition;

attribute vec4 vertex;
attribute vec4 color;
attribute vec3 normal;

varying vec4 vertColor;

void main() {
  gl_Position = transform * vertex;    
  vec3 ecVertex = vec3(modelview * vertex);  
  vec3 ecNormal = normalize(normalMatrix * normal);

  vec3 direction = normalize(lightPosition.xyz - ecVertex);    
  float intensity = min(pow(max(0.0, dot(direction, ecNormal)), 2.2), 1.0);
  vertColor = mix(color, vec4(0.9, 0.87, 0.1, 1.0), intensity);  
  vertColor = mix(vec4(intensity, intensity, intensity, 1)*color, vec4(normal, 1), 0.3);              
}