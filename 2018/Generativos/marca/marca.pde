int seed = int(random(999999));
void setup() {
  size(960, 960, P2D);
  smooth(8);
  pixelDensity(2);

  generate();
}

void draw() {
  //generate();
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
  background(25);

  for (int i = 0; i < 50; i++) {
    float x = random(width); 
    float y = random(height);
    float s = width*random(0.02, 0.4);


    int c1 = rcol();
    int c2 = rcol();
    while (c1 == c2) c2 = rcol();
    //ellipse(x, y, s, s);
    noStroke();
    arc2(x, y, s, s*3, 0, TAU, color(0), 10, 0);
    arc2(x, y, s, s*1.8, 0, TAU, rcol(), 20, 0);
    cgrad(x, y, s*0.8, s, c1, c2, 0.25);
    cgrad(x, y, s*0.6, s*0.8, c2, c1, 0.25);
    stroke(255, 10);
    poly(x, y, s*0.4, int(random(3, 7)), random(TAU), c1);
  }
}

void poly(float x, float y, float s, int seg, float a, int c1) {
  float r = s*0.5;
  float da = TWO_PI/seg; 
  for (int i = 0; i < seg; i++) {
    float a1 = da*i+a;
    float a2 = a1+da;
    beginShape();
    fill(rcol());
    vertex(x+cos(a1)*r, y+sin(a1)*r);
    fill(rcol());
    vertex(x+cos(a2)*r, y+sin(a2)*r);
    fill(c1);
    vertex(x, y);
    endShape(CLOSE);
  }
}

void cgrad(float x, float y, float s1, float s2, int c1, int c2, float a) {
  float r1 = s1*0.5; 
  float r2 = s2*0.5;

  int seg = max(8, int(s2*PI));
  float da = TWO_PI/seg;
  for (int i = 0; i < seg; i++) {
    float a1 = da*i;
    float a2 = a1+da;

    float v1 = cos(map(i, 0, seg, 0, TAU)+TAU*a)*0.5+0.5;
    float v2 = cos(map(i+1, 0, seg, 0, TAU)+TAU*a)*0.5+0.5;

    int col1 = lerpColor(c1, c2, v1);
    int col2 = lerpColor(c1, c2, v2);

    beginShape();
    fill(col1);
    vertex(x+cos(a1)*r2, y+sin(a1)*r2);
    vertex(x+cos(a1)*r1, y+sin(a1)*r1);
    fill(col2);
    vertex(x+cos(a2)*r1, y+sin(a2)*r1);
    vertex(x+cos(a2)*r2, y+sin(a2)*r2);
    endShape();
  }
}

void arc2(float x, float y, float s1, float s2, float a1, float a2, int col, float shd1, float shd2) {
  float r1 = s1*0.5;
  float r2 = s2*0.5;
  float amp = (a2-a1);
  float ma = map(amp, 0, TWO_PI, 0, 1);
  int cc = max(1, int(max(r1, r2)*PI*ma));
  float da = amp/cc;
  for (int i = 0; i < cc; i++) {
    float ang = a1+da*i;
    beginShape();
    fill(col, shd1);
    vertex(x+cos(ang)*r1, y+sin(ang)*r1);
    vertex(x+cos(ang+da)*r1, y+sin(ang+da)*r1);
    fill(col, shd2);
    vertex(x+cos(ang+da)*r2, y+sin(ang+da)*r2);
    vertex(x+cos(ang)*r2, y+sin(ang)*r2);
    endShape(CLOSE);
  }
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}
int colors[] = {#F8C43D, #023390, #6AA6E2, #F35076, #F6F6F6};
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