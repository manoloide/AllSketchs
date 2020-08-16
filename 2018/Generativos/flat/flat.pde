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
  int cc = int(random(4, random(40)));

  float px1 = random(1, 4);
  if (random(1) < 0.5) px1 = random(0.25, 1);
  float px2 = random(1, 4);
  if (random(1) < 0.5) px2 = random(0.25, 1);

  float py1 = random(1, 4);
  if (random(1) < 0.5) py1 = random(0.25, 1);
  float py2 = random(1, 4);
  if (random(1) < 0.5) py2 = random(0.25, 1);

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
      //fill(rcol());
      vertex(x2, y2);
      fill(rcol());
      vertex(x4, y4);
      vertex(x3, y3);
      endShape();


      float shw = dist(x1, y1, x2, y2)*0.1;
      beginShape();
      fill(0, 30);
      vertex(x1, y1);
      vertex(x4, y4);
      fill(0, 0);
      vertex(x4+10, y4-10);
      vertex(x1-10, y1-10);
      endShape();


      beginShape();
      fill(0, 30);
      vertex(x4, y4);
      vertex(x2, y2);
      fill(0, 0);
      vertex(x2+10, y2+10);
      vertex(x4+10, y4-10);
      endShape();


      beginShape();
      fill(0, 30);
      vertex(x2, y2);
      vertex(x3, y3);
      fill(0, 0);
      vertex(x3-10, y3+10);
      vertex(x2+10, y2+10);
      endShape();

      beginShape();
      fill(0, 30);
      vertex(x3, y3);
      vertex(x1, y1);
      fill(0, 0);
      vertex(x1-10, y1-10);
      vertex(x3-10, y3+10);
      endShape();

      /*
      fill(0, 30);
       beginShape();
       vertex(x1-10, y1-10);
       vertex(x4+10, y4-10);
       vertex(x2+10, y2+10);
       vertex(x3-10, y3+10);
       endShape();
       */


      beginShape();
      fill(rcol());
      vertex(x1, y1);
      //fill(rcol());
      vertex(x2, y2);
      fill(rcol());
      vertex(x3, y3);
      //fill(rcol());
      vertex(x4, y4);
      endShape();


      int c1 = rcol();
      int c2 = rcol();
      while (c1 == c2) c2 = rcol();
      int mc = lerpColor(c1, c2, 0.5);
      float cx = (x1+x2)*0.5;
      float cy = (y1+y2)*0.5;

      for (int l = 0; l < 4; l++) {
        float r = noise(des+cx*det, des+cy*det)*map(l, 0, 4, 0.4, 0);
        float rw = (x2-x1)*r;
        float rh = (y2-y1)*r;
        int res = (int)max(4, max(rw, rh)*PI);
        float da = TAU/res;
        fill(mc);
        for (int k = 0; k < res; k++) {
          float ang = da*k;

          beginShape();
          fill(0, 10);
          vertex(cx+cos(ang)*rw, cy+sin(ang)*rh);
          vertex(cx+cos(ang+da)*rw, cy+sin(ang+da)*rh);
          fill(0, 0);
          vertex(cx+cos(ang+da)*rw*2, cy+sin(ang+da)*rh*2);
          vertex(cx+cos(ang)*rw*2, cy+sin(ang)*rh*2);
          endShape();

          fill(lerpColor(c1, c2, sin(ang)*0.5+0.5));
          beginShape();
          vertex(cx+cos(ang)*rw, cy+sin(ang)*rh);
          vertex(cx+cos(ang+da)*rw, cy+sin(ang+da)*rh);
          fill(mc);
          vertex(cx, cy);
          endShape();
        }
      }
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

int colors[] = {#17E5DB, #5442AE, #A64AC9, #FD6519, #FDCF00, #FFFFFF};
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