InjectShader rs;

void setup() {
  size(600, 600, P2D);
  rs = new InjectShader("shaders/shader1.glsl");
}

void draw() {
  rs.shader.set("resolution", float(width), float(height));
  rs.shader.set("time", millis()/1000.0);
  float x = map(mouseX, 0, width, 0, 1);
  float y = map(mouseY, 0, height, 1, 0);
  rs.shader.set("mouse", x, y);
  shader(rs.shader);
  rect(0, 0, width, height);
  rs.update();
}

