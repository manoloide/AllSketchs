void setup() {
  size(960, 960);
  pixelDensity(2);
}

void draw() {

  background(255);
  translate(width/2, height/2);

  float time = millis()*0.01; 

  int ld = 3;
  int sub = 80;
  int cc = ld*sub;

  PVector p1[] = new PVector[cc];
  PVector p2[] = new PVector[cc];

  float r1 = width*(0.45+cos(time*0.1)*0.2);
  for (int j = 0; j < ld; j++) {
    float da = TWO_PI/ld;
    float ang = da*j-time*0.01;
    float x1 = cos(ang)*r1;
    float x2 = cos(ang+da)*r1;
    float y1 = sin(ang)*r1;
    float y2 = sin(ang+da)*r1;
    for (int i = 0; i < sub; i++) {
      float x = map(i, 0, sub, x1, x2);
      float y = map(i, 0, sub, y1, y2);
      p1[j*sub+i] = new PVector(x, y);
    }
  }

  float r2 = width*0.18;
  float da = TWO_PI/cc;
  for (int i = 0; i < cc; i++) {
    float ang = da*i+time*0.1;
    p2[i] = new PVector(cos(ang)*r2, sin(ang)*r2);
  }

  stroke(0, 80);
  for (int i = 0; i < cc; i++) {
    line(p1[i].x, p1[i].y, p2[i].x, p2[i].y);
  }
}