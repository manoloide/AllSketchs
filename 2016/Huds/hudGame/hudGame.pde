Canvas canvas;

void setup() {
  //fullScreen();
  size(960, 960, P2D);
  canvas = new Canvas();
  //surface.setResizable(true);
}

void draw() {
  background(#240615);
  noStroke();
  fill(255, 25);
  translate(width/2, height/2);
  gridQuad(width, height, 20, 2);
  stroke(255, 25);
  strokeWeight(1);
  gridSimple(width, height, 80);
  strokeWeight(2);
  gridCross(width, height, 160, 10);

  canvas.update();
}

void keyPressed() {
  if (keyCode == LEFT) {
    canvas.camera.rectMove(1, 0);
  }
  if (keyCode == RIGHT) {
    canvas.camera.rectMove(-1, 0);
  }
  if (keyCode == UP) {
    canvas.camera.rectMove(0, -1);
  }
  if (keyCode == DOWN) {
    canvas.camera.rectMove(0, 1);
  }
}

void mouseDragged() {
  canvas.camera.moved();
}


void gridQuad(float w, float h, int cc, int ss) {
  float mw = w/2;
  float mh = h/2;
  rectMode(CENTER);
  for (int j = 0; j < h+cc; j+=cc) {
    for (int i = 0; i < w+cc; i+=cc) {
      rect(i-mw, j-mh, ss, ss);
    }
  }
}

void gridCross(float w, float h, int cc, float ss) {
  float mw = w/2;
  float mh = h/2;
  ss *= 0.5;
  for (int j = 0; j < h+cc; j+=cc) {
    for (int i = 0; i < w+cc; i+=cc) {
      line(i-mw-ss, j-mh, i-mw+ss, j-mh);
      line(i-mw, j-mh-ss, i-mw, j-mh+ss);
    }
  }
}

void gridSimple(float w, float h, int cc) {
  float mw = w/2;
  float mh = h/2;
  for (int i = 0; i < w+cc; i+=cc) {
    line(i-mw, -mh, i-mw, mh);
  } 
  for (int i = 0; i < h+cc; i+=cc) {
    line(-mw, i-mh, mw, i-mh);
  }
}