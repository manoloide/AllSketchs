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