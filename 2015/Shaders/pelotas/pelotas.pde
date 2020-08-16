PShader toon;

void setup() {
  size(800, 600, P3D);
  ortho(0, width, 0, height);

  toon = loadShader("ToonFrag.glsl", "ToonVert.glsl");
  toon.set("fraction", 1.0);
}

void draw() {
  shader(toon);
  background(10);
  float dirX = 0.5;
  float dirY = 0;
  directionalLight(200, 255, 255, -dirX, -dirY, -1);
  int sep = 100;
  noStroke(); 
  randomSeed(1);
  for (int j = sep/2; j < height; j+=sep) {
    for (int i = sep/2; i < width; i+=sep) {

      fill(random(255), random(255), random(100));
      pushMatrix();
      float ang = atan2(mouseY-j, mouseX-i);
      float dis = dist(mouseX, mouseY, i, j);
      float x = i;
      float y = j;
      float d = max(4, pow(8,map(dis, 0, 180, 2.2, 1))); 
      sphereDetail(max(int(d), 12));
      translate(i, j, -60);
      sphere(d);
      popMatrix();
    }
  }
}

