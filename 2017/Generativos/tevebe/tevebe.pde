int seed = int(random(999999));

void setup() {
  size(960, 720, P3D);
  smooth(8);
  pixelDensity(2);
  generate();
}

void draw() {
  //if (frameCount%40 == 0) generate();

  render();
}

void keyPressed() {
  if (key == 's') saveImage();
  else generate();
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

void generate() {
  seed = int(random(999999));
  render();
}

void render() {

  noiseSeed(seed);
  randomSeed(seed);

  noStroke();
  int ch = int(random(1, 18));
  float h = height*1./ch;
  for (int j = 0; j < ch; j++) {
    int cw = int(random(1, 80));
    float w = width*1./cw; 
    int col = rcol();
    float dd = random(50)/w; 
    float dt = random(1)+frameCount*random(-0.1, 0.1);
    float pwr = random(0.5, 2);
    for (int i = 0; i < cw; i++) {
      float val = abs((dt+dd*i)%1);

      val = pow(val, pwr);
      val = abs(val*2-1);
      if (val < 0.5) fill(lerpColor(color(0), color(col), map(val, 0, 0.5, 0, 1)));
      else fill(lerpColor(color(col), color(255), map(val, 0.5, 1.0, 0, 1)));
      //if (val 
      //fill(val*255);
      rect(i*w, j*h, w, h);
    }
  }
} 

int colors[] = {#F05638, #F5C748, #3FD189, #FFB9DB, #AF8AB4, #6FC4EA, #FFFFFF, #412A50};
int rcol() {
  return colors[int(random(colors.length))];
}
//int colors[] = {#45171D, #F03861, #FF847C, #FECEA8};

int getColor(float v) {
  v = v%(colors.length);

  int c1 = colors[int(v%colors.length)];
  int c2 = colors[int((v+1)%colors.length)];
  float m = v%1;

  //m = pow(m, 4);
  //return c1;
  return lerpColor(c1, c2, m);
}