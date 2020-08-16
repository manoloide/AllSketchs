#define PROCESSING_TEXTURE_SHADER

uniform mat4 transform;
uniform mat4 texMatrix;

attribute vec4 vertex;
attribute vec4 color;
attribute vec2 texCoord;

varying vec4 vertTexCoord;

void main() {
  gl_Position = transform * vertex;
  vertTexCoord = texMatrix * vec4(texCoord, 1.0, 1.0); // pass texture coordinates to the fragment shader
}
