int seed = int(random(99999999));

void setup() {
  //size(displayWidth, displayHeight, P2D);
  fullScreen(P2D);
  smooth(4);

  generate();
}

void draw() {
}

void keyPressed() {
  generate();
}

void generate() {

  background(250);

  int cc = int(random(2, 10));
  float ss = height*1./(cc+2);

  float dx = (width-(ss*cc))*0.5;
  float dy = (height-(ss*cc))*0.5;
  noStroke();
  fill(0);
  for (int j = 0; j < cc; j++) {
    for (int i = 0; i < cc; i++) {
      float xx = dx+(i+0.5)*ss;
      float yy = dy+(j+0.5)*ss;
      ellipse(xx, yy, ss*0.2, ss*0.2);
    }
  }
}
