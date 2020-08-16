uniform mat4 transformMatrix;
uniform float tween;

attribute vec4 position;
attribute vec4 tweened;
attribute vec4 color;

varying vec4 vertColor;

void main() {
  gl_Position = transformMatrix * ((1.0 - tween) * position + tween * tweened);
    
  vertColor = color;
}