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

  randomSeed(seed);
  //background(rcol());
  beginShape();
  fill(rcol());
  vertex(0, 0);
  vertex(width, 0);
  fill(rcol());
  vertex(width, height);
  vertex(0, height);
  endShape();
  int cc = int(random(4, random(560)));

  float maxPow = random(80);
  float px1 = random(1, maxPow);
  if (random(1) < 0.5) px1 = random(1./maxPow, 1);
  float px2 = random(1, maxPow);
  if (random(1) < 0.5) px2 = random(1./maxPow, 1);

  float py1 = random(1, maxPow);
  if (random(1) < 0.5) py1 = random(1./maxPow, 1);
  float py2 = random(1, maxPow);
  if (random(1) < 0.5) py2 = random(1./maxPow, 1);

  //px1 = px2 = py1 = py2 = 2;


  float det = random(0.01);
  float des = random(1000);

  noStroke();
  for (int j = 0; j < cc; j++) {
    for (int i = 0; i < cc; i++) {
      float vx1 = map(i, 0, cc, 0, 1); 
      float vx2 = map(i+1, 0, cc, 0, 1); 
      float vy1 = map(j, 0, cc, 0, 1);
      float vy2 = map(j+1, 0, cc, 0, 1); 

      float x1 = pow(vx1, map(j, 0, cc, px1, px2));
      float x2 = pow(vx2, map(j+1, 0, cc, px1, px2));
      float x3 = pow(vx1, map(j, 0, cc, px1, px2));
      float x4 = pow(vx2, map(j+1, 0, cc, px1, px2));
      float y1 = pow(vy1, map(i, 0, cc, py1, py2));
      float y2 = pow(vy2, map(i+1, 0, cc, py1, py2));
      float y3 = pow(vy2, map(i, 0, cc, py1, py2));
      float y4 = pow(vy1, map(i +1, 0, cc, py1, py2));

      x1 *= width;
      x2 *= width;
      x3 *= width;
      x4 *= width;
      y1 *= height;
      y2 *= height;
      y3 *= height;
      y4 *= height;

      beginShape();
      fill(rcol());
      vertex(x1, y1);
      vertex(x3, y3);
      //fill(rcol());
      fill(rcol());
      vertex(x2, y2);
      vertex(x4, y4);
      endShape();
    }
  }
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

void arc2(float x, float y, float s1, float s2, float a1, float a2, int col, float alp1, float alp2) {
  float r1 = s1*0.5;
  float r2 = s2*0.5;
  float amp = (a2-a1);
  float ma = map(amp, 0, TWO_PI, 0, 1);
  int cc = max(2, int(max(r1, r2)*PI*ma));
  float da = amp/cc;
  for (int i = 0; i < cc; i++) {
    float ang = a1+da*i;
    beginShape();
    fill(col, alp1);
    vertex(x+cos(ang)*r1, y+sin(ang)*r1);
    vertex(x+cos(ang+da)*r1, y+sin(ang+da)*r1);
    fill(col, alp2);
    vertex(x+cos(ang+da)*r2, y+sin(ang+da)*r2);
    vertex(x+cos(ang)*r2, y+sin(ang)*r2);
    endShape(CLOSE);
  }
}

int colors[] = {#F00050, #FF4E02, #F9E702, #028DF9, #1629C6};
//int colors[] = {#010187, #0A49FF, #FF854E, #FFCAE3, #FFFFFF};
//int colors[] = {#27007F, #00A6FF, #FF216E, #FFB7E3, #FFFFFF};
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