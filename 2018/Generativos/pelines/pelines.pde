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

  noStroke();
  stroke(0, 8);
  fill(rcol());
  rect(0, 0, width, height);

  float gri = 20;

  float det1 = random(0.01);
  float des1 = random(1000);
  float det2 = random(0.01);
  float des2 = random(1000);
  float det3 = random(det1)*random(0.1);
  float des3 = random(1000);
  for (float gy = -gri; gy < height+gri; gy+=gri*0.1) {
    for (float gx = -gri; gx < width+gri; gx+=gri*0.1) {
      float xx = gx+gri*0.5;
      float yy = gy+gri*0.5;
      float an = noise(des1+xx*det1, des1+yy*det1)*TAU*2;
      float dd = noise(des2+xx*det2, des2+yy*det2)*gri;
      float x1 = constrain(xx, 0, width);
      float y1 = constrain(yy, 0, height);
      float x2 = constrain(xx+cos(an)*dd, 0, width);
      float y2 = constrain(yy+sin(an)*dd, 0, height);
      stroke(getColor(noise(des3+xx*det3, des3+yy*det3)*colors.length*20), random(120)*random(0.2, 1));
      line(x1, y1, x2, y2);
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

void montains(float x, float y, float w, float h) {
  FloatList p = new FloatList();
  p.append(0);
  p.append(w);
  for (int i = 0; i < 10; i++) {
    p.append(random(w));
  }
  p.sort();

  int c1 = rcol();
  int c2 = rcol();
  beginShape();
  for (int i = 0; i < p.size()-1; i++) {
    float v1 = p.get(i);
    float v2 = p.get(i+1);
    float m = lerp(v1, v2, random(0.2, 0.8));
    float hh = map(v2-v1, 0, w, 0, h);//*random(5);
    fill(c1);
    if (i == 0) vertex(x+v1, y+h);
    fill(c2);
    vertex(x+m, y+h-hh);
    fill(c1);
    vertex(x+v2, y+h);
  }
  endShape(CLOSE);
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