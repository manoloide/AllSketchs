uniform mat4 transformMatrix;
uniform float tween;
uniform float time;

attribute vec4 position;
attribute vec4 tweened;
attribute vec4 color;

varying vec4 vertColor;
varying vec4 vertTexCoord;

void main() {
    
    float h = cos(position.x*time*0.01)+cos(position.y*time*0.2)*0.01;
    gl_Position = transformMatrix * ((1.0 - tween) * position + tween * h);
    
    vertColor = color;
}
