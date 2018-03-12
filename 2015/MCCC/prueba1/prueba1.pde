boolean save = true;
int seed = 0;
int paleta[] = {
  #2537b5, 
  #ff3804, 
  #000000, 
  #ffffff
};

float time = 0;

void setup() {
  size(350, 350);
  frameRate(10);
  generate();
}

void draw() {
  time += 1/10.;
  if (time >= 1) {
    generate();
    time = 0;
  }
  randomSeed(seed);
  background(rcol());
  int tt = int(random(6, 16));
  int sep = int(tt*random(1.4, 2.5));
  int cc = int(random(30, 80)/tt);
  float ss = random(1);
  for (int j = -cc; j <= cc; j++) {
    for (int i = -cc; i <= cc; i++) {
      float x = width/2+i*sep;
      float y = height/2+j*sep;
      float s = max(0, tt-dist(0, 0, i*2, j*2)*ss);
      noStroke();
      fill(rcol());
      ellipse(x, y, s, s);
      if (random(1) < 0.5) {
        float a2 = random(TWO_PI)+time*random(0.5, 5);
        float a1 = a2-random(TWO_PI)*map(time, 0, 1, 1, -random(0.2));
        stroke(rcol());
        noFill();
        strokeWeight(s*random(0.05, 0.2));
        arc(x, y, s*1.4, s*1.4, a1, a2);
      }
    }
  }

  if (save) {
    saveFrame("export/#####.png");
    if (frameCount > 20*10) {
      exit();
    }
  }
}

void keyPressed() {
  if (key == 's') saveImage();
  else generate();
}

void generate() {
  seed = int(random(99999999));
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

int rcol() {
  return paleta[int(random(paleta.length))];
}

