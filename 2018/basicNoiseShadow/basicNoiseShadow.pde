PShader noi;

void setup() {
  size(640, 640, P2D);
  pixelDensity(2);
  smooth(8);

  noi = loadShader("noiseShadowFrag.glsl", "noiseShadowVert.glsl");
}

void draw() {
  background(240);

  float x = 220;
  float y = 220;
  float s = 200;
  float b = 100;

  //todo lo que dibujes apartir de ahora va tener ruido
  shader(noi);
  
  noStroke();
  beginShape();
  fill(0, 40);
  vertex(x+s, y);
  vertex(x+s, y+s);
  fill(0, 0);
  vertex(x+s+b, y+s+b);
  vertex(x+s+b, y+b);
  endShape(CLOSE);
  beginShape();
  fill(0, 40);
  vertex(x, y+s);
  vertex(x+s, y+s);
  fill(0, 0);
  vertex(x+s+b, y+s+b);
  vertex(x+b, y+s+b);
  endShape(CLOSE);

  //se apagar el ruido
  resetShader();
  fill(180);
  noStroke();
  rect(x, y, s, s);
}