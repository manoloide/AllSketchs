PImage grad;
PShader shader;

void setup() {
  size(640, 640, P2D);
  noStroke();

  grad = loadImage("pal.png");
}

void draw() {

  shader = loadShader("shader.glsl");
  shader.set("grad", grad);
  shader.set("resolution", float(width), float(height));
  shader.set("time", millis() / 500.0);  

  shader(shader); 
  rect(0, 0, width, height);
}
