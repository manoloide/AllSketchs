int seed = int(random(999999));

void setup() {
  size(960, 960, P2D);
  smooth(8);
  pixelDensity(2);

  generate();
}

void draw() {
}

void keyPressed() {
  if (key == 's') saveImage();
  else {
    seed = int(random(999999));
    generate();
  }
}

void generate() {
  background(rcol());

  float det = random(0.01);
  float des = random(100000);
  int cc = int(random(300, 1000));
  for (int i = 0; i < cc; i++) {
    float mm = map(i, 0, cc, 0.1, 0.0);
    float x = random(width);
    float y = random(height);
    float noi = noise(des+x*det, des+y*det);
    float r = width*(mm+0.001+noi*0.05);
    float ma = random(0.2, 0.9);

    flo(x, y, r, ma);
  }

  cc = int(random(1, random(1, 4)));
  for (int i = 0; i < cc; i++) {
    float ma = random(0.8, 0.9);
    float x = width*random(0.2, 0.8);
    float y = height*random(0.2, 0.8);
    flo(x, y, width*random(0.4, 1.0)*map(i, 0, cc, 0.2, 1), ma);
  }
}

void flo(float x, float y, float rad, float ma) {
  pushMatrix();
  translate(x, y);
  noStroke();
  float r = rad;
  while (r > 2) {


    float an = random(TWO_PI);
    float dis = random(0.5, 0.8);
    float cx = cos(an)*r*dis;
    float cy = sin(an)*r*dis;

    int sub = int(random(80, 260));
    float da = TWO_PI/sub;
    float ang = random(TWO_PI);
    float ic = random(colors.length);
    float dc = (colors.length*int(random(2, random(2, 40))))*1./sub;
    float det = random(2);
    float des = random(100000);

    pushMatrix();
    translate(map(r, 0, rad, 0, cx), map(r, 0, rad, 0, cy));
    for (int i = 0; i < sub; i++) {
      float a1 = ang+i*da;
      float a2 = ang+i*da+da;
      float n1 = noise(des+cos(a1)*det, des+sin(a1)*det);
      float n2 = noise(des+cos(a2)*det, des+sin(a2)*det);
      float r1 = map(n1, 0, 1, r, r*ma*ma);
      float r2 = map(n2, 0, 1, r, r*ma*ma);

      fill(rcol());
      //fill(getColor(ic+dc*i));
      beginShape();
      fill(0, 50);
      vertex(cos(a1)*r1, sin(a1)*r1);
      vertex(cos(a2)*r2, sin(a2)*r2);
      fill(0, 0);
      vertex(cos(a2)*r2*1.2, sin(a2)*r2*1.2);
      vertex(cos(a1)*r1*1.2, sin(a1)*r1*1.2);
      endShape(CLOSE);

      fill(rcol());
      //fill(getColor(ic+dc*i));
      beginShape();
      vertex(0, 0);
      vertex(cos(a1)*r1, sin(a1)*r1);
      vertex(cos(a2)*r2, sin(a2)*r2);
      endShape(CLOSE);
    }
    popMatrix();
    r *= ma;
  }
  popMatrix();
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

int colors[] = {#D81D03, #101A9D, #1C7E4E, #F6A402, #EFD4BF, #E2E0EF, #050400};
int rcol() {
  return colors[int(random(colors.length))];
}
int getColor() {
  return getColor(random(colors.length));
}
int getColor(float v) {
  v = abs(v);
  v = v%(colors.length); 
  int c1 = colors[int(v%colors.length)]; 
  int c2 = colors[int((v+1)%colors.length)]; 
  return lerpColor(c1, c2, v%1);
}