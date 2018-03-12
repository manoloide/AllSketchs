int seed = int(random(99999999));

void setup() {
  size(960, 960);
  pixelDensity(2);
  generate();
}

void draw() {
}

void keyPressed() {
  if (key == 's') saveImage();
  else {
    seed = int(random(9999999));
    generate();
  }
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

void generate() {

  randomSeed(seed);

  int x = 0; 
  int y = 0; 
  int w = width*2; 
  int h = height*2;

  float v1 = random(0.2)*random(1);
  float v2 = random(1)*random(1);

  float d11 = random(-v1, v1);
  float d12 = random(-v1, v1);
  float d13 = random(-v2, v2);
  float d14 = random(-v2, v2);

  float d21 = random(-v1, v1);
  float d22 = random(-v1, v1);
  float d23 = random(-v2, v2);
  float d24 = random(-v2, v2);

  float time = millis()*0.01;
  float i1 = random(100);
  float i2 = random(100);
  float i3 = random(100);
  float i4 = random(100);

  float det = random(0.01)*random(1);
  float des = random(1000);
  float cc = random(3)*random(1);
  float ic = random(colors.length);
  for (int j = y; j < y+h; j++) {
    for (int i = x; i < x+w; i++) {
      float val = noise(des+i*det, des+j*det);
      float d1 = lerp(d11, d21, val);
      float d2 = lerp(d12, d22, val);
      float d3 = lerp(d13, d23, val);
      float d4 = lerp(d14, d24, val);
      float xx = cos(i1+i*d1)+cos(i3+i*d3);
      float yy = sin(i2+j*d2)+cos(i4+i*d4);
      float col = map(xx*yy, -1, 1, 0, 1);
      set(i, j, getColor(ic+col*colors.length*cc));
    }
  }
}

int colors[] = {#000000, #FFFFFF, #FF7700, #000000, #15FF4A, #000000, #000000, #BBBBFF};
int rcol() {
  return colors[int(random(colors.length))];
};
int getColor(float v) {
  v = (v%(colors.length)+colors.length)%colors.length;
  int c1 = colors[int(v%colors.length)];
  int c2 = colors[int((v+1)%colors.length)];
  float m = v%1;
  return lerpColor(c1, c2, m);
}