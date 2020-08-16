
//47,5 x 4

int cw = 6/2;
int ch = 36/1;

float w = 60;
float h = 20;

float values[][];

PImage t;
boolean rot = false;

void settings() {
  if (rot) size(int(h*ch), int(w*cw), P2D);
  else size(int(w*cw), int(h*ch), P2D);
  pixelDensity(2);
  smooth(2);
}

void setup() {

  values = new float[cw][ch];
  t = loadImage("brush03.png");
}

int seed = int(random(99999999));
float desNoi = random(100);

void draw() {

  if (frameCount%(60*20) == 0) {
    generate();
  }

  if (rot) {
    translate(0, height);
    rotate(-HALF_PI);
  }

  background(30);
  noStroke();
  imageMode(CENTER);
  rectMode(CENTER);

  randomSeed(seed);
  noiseSeed(seed);

  float det1 = random(0.01)*random(1);
  float des1 = random(1000);
  float det2 = random(0.1)*random(1)*random(1)*random(1);
  float des2 = random(1000);

  desNoi += random(0.01)*random(1)*random(1);


  float dd = w/h;
  for (int j = 0; j < ch; j++) {
    for (int i = 0; i < cw; i++) {
      float x = (i+0.5)*w;
      float y = (j+0.5)*h;
      float n1 = noise(des1+x*dd*det1, des1+y*det1, desNoi);
      float n2 = noise(des2+x*dd*det2, des2+y*det2, desNoi);
      float val = pow(n1, 0.8);

      if (n2 < 0.5) {
        val = pow(1-val, 2);
      }

      values[i][j] = val;
    }
  }

  showValues();
}

void showValues() {
  blendMode(NORMAL);
  for (int j = 0; j < ch; j++) {
    for (int i = 0; i < cw; i++) {
      float x = (i+0.5)*w;
      float y = (j+0.5)*h;

      fill(40);
      rect(x, y, w, h-2);
    }
  }

  for (int j = 0; j < ch; j++) {
    for (int i = 0; i < cw; i++) {

      float x = (i+0.5)*w;
      float y = (j+0.5)*h;
      float val = values[i][j];

      blendMode(NORMAL);

      fill(255, 0, 0, 80*val);
      rect(x, y, w, h-4);

      tint(255, 0, 0, 255*val);
      noTint();
      fill(255, 0, 0, 255*val);
      //image(t, x, y, h*0.6, h*0.6);
      ellipse(x, y, h*0.2, h*0.2 );

      tint(255, 0, 0, 160*val);
      blendMode(ADD);
      image(t, x, y, h*4.6*val, h*4.6*val);
      image(t, x, y, w*1.4, h*1.2);
      //ellipse(x, y, h*0.8, h*0.8);
    }
  }
}

void generate() {
  seed = int(random(99999));
}

void keyPressed() {
  seed = int(random(99999999));
}
