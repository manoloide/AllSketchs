// frag.glsl
#version 150

uniform mat4 transform;

in vec4 vertColor;

out vec4 fragColor;

void main() {
  fragColor = vertColor;
}