int seed;
int paleta[];

void setup() {
  size(800, 600, P3D);
  generar();
}

void draw() {
  for (int j = 0; j < height; j++) {
    for (int i = 0; i < width; i++) {
      color col = lerpColor(paleta[0], paleta[1], j*0.4/height);
      float osc = random(-4, 4);
      col = color(red(col)+osc, green(col)+osc, blue(col)+osc);
      set(i, j, col);
    }
  }

  for (int i = 0; i < 3; i++) {
    float xx = 20 + i*40;
    float yy = 20;
    fill(paleta[i]);
    stroke(256);
    rect(xx, yy, 32, 32, 2);
  }
  translate(width/2, height/2, -200);
  rotateX(frameCount*0.0347);
  rotateY(frameCount*0.0247);
  fill(paleta[1]);
  noStroke();
  sphere(200);
  
  int ar = int(random(99999999));
  randomSeed(seed);
  for (int i = 0; i < 30; i++) {
    float a1 = random(TWO_PI);
    float a2 = random(TWO_PI);
    float dd = 240+cos(frameCount*0.4)*30;
    float x = cos(a1)*sin(a2)*dd;
    float y = sin(a1)*sin(a2)*dd;
    float z = cos(a2)*dd;
    pushMatrix();
    translate(x, y, z);
    fill(paleta[2]);
    sphere(random(2, 20));
    popMatrix();
  }
  randomSeed(ar);
}

void keyPressed() {
  generar();
}

void generar() {
  seed = int(random(999999999));
  pushStyle();
  colorMode(HSB, 256, 256, 256);
  paleta = new int[3];
  paleta[0] = color(random(256), 160, 200);
  paleta[1] = color((hue(paleta[0])+128)%256, 80, 200);
  paleta[2] = color(hue(paleta[1]), 30, 250);
  popStyle();
}
