int seed = int(random(999999));

void setup() {
  size(960, 960, P2D);
  smooth(8);
  pixelDensity(2);
  generate();
}

void draw() {
  //if (frameCount%60 == 0) generate();
}

void keyPressed() {
  if (key == 's') saveImage();
  else {
    seed = int(random(999999));
    generate();
  }
}

class Rect {
  float x, y, w, h;
  Rect(float x, float y, float w, float h) {
    this.x = x; 
    this.y = y; 
    this.w = w; 
    this.h = h;
  }
}

void generate() {
  background(rcol());

  int cc = int(random(12, 21));
  float ss = width*1./cc;
  float bb = ss*0.18;

  float alp = 100;
  noStroke();

  float det = random(0.01);
  float des = random(1000);
  int c1 = int(random(4));
  int c2 = int(random(4));
  for (int j = 0; j < cc; j++) {
    for (int i = 0; i < cc; i++) {
      float xx = i*ss;
      float yy = j*ss;
      if ((i+j)%2 == 0) fill(80, 0, 200);
      else fill(80, 200, 0);

      int ind = j*c1*cc+i*c2;

      rect(xx, yy, ss, ss);

      int col = color(255);

      float ang = ind*HALF_PI;
      //ang = int(noise(des+xx*det, des+yy*det)*4)*HALF_PI;

      if (cos(ang) < 0) col = color(255);
      else col = color(0);
      beginShape();
      fill(col, alp);
      vertex(xx, yy);
      vertex(xx+ss, yy);
      fill(col, 0);
      vertex(xx+ss-bb, yy+bb);
      vertex(xx+bb, yy+bb);
      endShape(CLOSE);

      ang += HALF_PI;
      if (cos(ang) < 0) col = color(255);
      else col = color(0);
      beginShape();
      fill(col, alp);
      vertex(xx+ss, yy+ss);
      vertex(xx+ss, yy);
      fill(col, 0);
      vertex(xx+ss-bb, yy+bb);
      vertex(xx+ss-bb, yy+ss-bb);
      endShape(CLOSE);

      ang += HALF_PI;
      if (cos(ang) < 0) col = color(255);
      else col = color(0);
      beginShape();
      fill(col, alp);
      vertex(xx+ss, yy+ss);
      vertex(xx, yy+ss);
      fill(col, 0);
      vertex(xx+bb, yy+ss-bb);
      vertex(xx+ss-bb, yy+ss-bb);
      endShape(CLOSE);

      ang += HALF_PI;
      if (cos(ang) < 0) col = color(255);
      else col = color(0);
      beginShape();
      fill(col, alp);
      vertex(xx, yy);
      vertex(xx, yy+ss);
      fill(col, 0);
      vertex(xx+bb, yy+ss-bb);
      vertex(xx+bb, yy+bb);
      endShape(CLOSE);
    }
  }
}


void arc2(float x, float y, float s1, float s2, float a1, float a2, int col, float alp1, float alp2) {
  float r1 = s1*0.5;
  float r2 = s2*0.5;
  float amp = (a2-a1);
  float ma = map(amp, 0, TWO_PI, 0, 1);
  int cc = max(1, int(max(r1, r2)*PI*ma));
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

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

//int colors[] = {#E70012, #D3A100, #017160, #00A0E9, #072B45};
//int colors[] = {#2E0551, #FF00C7, #01AFC2, #FDBE03, #F4F9FD};
//int colors[] = {#2E601D, #E4428D, #F798D3, #1C506E, #04192C};
int colors[] = {#31A151, #FFA71E, #05084C, #DE4638, #3DBDB7};
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