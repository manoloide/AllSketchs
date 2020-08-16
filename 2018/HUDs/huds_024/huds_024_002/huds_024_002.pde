int seed = int(random(999999));
Camera camera;
ArrayList<Screen> screens;
float time;

void setup() {
  size(960, 540, P3D);
  smooth(2);
  pixelDensity(2);

  ortho();

  camera = new Camera();

  generate();
}

void draw() {

  time = millis()*0.001;

  randomSeed(seed);
  background(0);

  float ss = 60;
  float ww = height-60;
  float hh = ww;

  pushMatrix();
  camera.update();

  noFill();
  stroke(255, 50);
  gridRect(-ww*0.5, -hh*0.5, ww, hh, ss, 5);
  stroke(255);
  gridPoint(-ww*0.5, -hh*0.5, ww, hh, ss);

  pushMatrix();
  translate(0, 0, 1);
  for (int i = 0; i < screens.size(); i++) {
    Screen screen = screens.get(i);
    screen.update();
    screen.show();
  }
  popMatrix();
  popMatrix();
}

void keyPressed() {
  if (key == 's') saveImage();
  else if (keyCode == LEFT) camera.rotLeft();
  else if (keyCode == RIGHT) camera.rotRight();
  else if (key == ' ') camera.goToOrtho = !camera.goToOrtho;
  else {
    seed = int(random(999999));
    generate();
  }
}

void generate() {
  randomSeed(seed);

  createScreens();
}

void createScreens() {
  screens = new ArrayList<Screen>();
  
  
  float ss = 60;
  float ww = height-60;
  float hh = ww;
  
  screens.add(new Screen(-ww*0.5, -hh*0.5, ww, hh));
  int div = int(random(20)*random(0.2, 1));
  for (int i = 0; i < div; i++) {
    int ind = int(random(screens.size()));
    Screen r = screens.get(ind);
    int cw = int(r.w/ss);
    int ch = int(r.h/ss);
    if (cw < 2 || ch < 2) continue;
    int nw = int(random(1, cw));
    int nh = int(random(1, ch));
    screens.add(new Screen(r.x, r.y, nw*ss, nh*ss));
    screens.add(new Screen(r.x+nw*ss, r.y, (cw-nw)*ss, nh*ss));
    screens.add(new Screen(r.x+nw*ss, r.y+nh*ss, (cw-nw)*ss, (ch-nh)*ss));
    screens.add(new Screen(r.x, r.y+nh*ss, nw*ss, (ch-nh)*ss));
    screens.remove(ind);
  }
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}


void gridPoint(float x, float y, float w, float h, float ss) {
  int cw = int(w/ss);
  int ch = int(h/ss);
  for (int j = 0; j <= ch; j++) {
    for (int i = 0; i <= cw; i++) {
      point(x+i*ss, y+j*ss);
    }
  }
}

void gridRect(float x, float y, float w, float h, float dd, float ss) {
  int cw = int(w/dd);
  int ch = int(h/dd);
  pushStyle();
  rectMode(CENTER);
  for (int j = 0; j <= ch; j++) {
    for (int i = 0; i <= cw; i++) {
      rect(x+i*dd, y+j*dd, ss, ss);
    }
  }
  popStyle();
}
