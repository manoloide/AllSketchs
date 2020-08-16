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
  noStroke();
  float cx = width*0.5;
  float cy = height*0.5;
  float dd = width*0.72;
  for (int i = 0; i < 1000; i++) {
    float a1 = random(TWO_PI);
    float a2 = random(TWO_PI);
    float r1 = width*random(0.04)*random(1);
    float r2 = width*random(0.04)*random(1);
    float r = max(r1, r2);
    float x1 = cx+cos(a1)*dd;
    float y1 = cy+sin(a1)*dd;
    float x2 = cx+cos(a2)*dd;
    float y2 = cy+sin(a2)*dd;
    float ang = atan2(y2-y1, x2-x1)+HALF_PI;


    /*
    beginShape();
     fill(0, 4);
     vertex(x2, y2);
     vertex(x1, y1);
     fill(0, 0);
     vertex(x1-cos(ang)*r*4, y1-sin(ang)*r*4);
     vertex(x2-cos(ang)*r*4, y2-sin(ang)*r*4);
     endShape(CLOSE);
     
     beginShape();
     fill(0, 4);
     vertex(x2, y2);
     vertex(x1, y1);
     fill(0, 0);
     vertex(x1+cos(ang)*r*4, y1+sin(ang)*r*4);
     vertex(x2+cos(ang)*r*4, y2+sin(ang)*r*4);
     endShape(CLOSE);
     */

    beginShape();
    fill(0, 80);
    vertex(x2, y2);
    vertex(x1, y1);
    fill(0, 0);
    vertex(x1-cos(ang)*r*2, y1-sin(ang)*r*2);
    vertex(x2-cos(ang)*r*2, y2-sin(ang)*r*2);
    endShape(CLOSE);

    beginShape();
    fill(0, 80);
    vertex(x2, y2);
    vertex(x1, y1);
    fill(0, 0);
    vertex(x1+cos(ang)*r*2, y1+sin(ang)*r*2);
    vertex(x2+cos(ang)*r*2, y2+sin(ang)*r*2);
    endShape(CLOSE);


    fill(rcol());
    beginShape();
    vertex(x1-cos(ang)*r1, y1-sin(ang)*r1);
    vertex(x1+cos(ang)*r1, y1+sin(ang)*r1);
    vertex(x2+cos(ang)*r2, y2+sin(ang)*r2);
    vertex(x2-cos(ang)*r2, y2-sin(ang)*r2);
    endShape(CLOSE);

    int div = int(random(32, 120));
    fill(rcol());
    for (int j = 0; j < div; j++) {
      float m1 = map(j, 0, div, 0, 1);
      float m2 = map(j+0.5, 0, div, 0, 1);

      float xx1 = lerp(x1, x2, m1);
      float yy1 = lerp(y1, y2, m1);
      float xx2 = lerp(x1, x2, m2);
      float yy2 = lerp(y1, y2, m2);
      float rr1 = lerp(r1, r2, m1);
      float rr2 = lerp(r1, r2, m2);
      beginShape();
      vertex(xx1-cos(ang)*rr1, yy1-sin(ang)*rr1);
      vertex(xx1+cos(ang)*rr1, yy1+sin(ang)*rr1);
      vertex(xx2+cos(ang)*rr2, yy2+sin(ang)*rr2);
      vertex(xx2-cos(ang)*rr2, yy2-sin(ang)*rr2);
      endShape(CLOSE);
    }
  }

  for (int i = 0; i < 50; i++) {
    float x = random(width);
    float y = random(height);
    float s = width*random(0.8)*random(1)*random(1);

    arc2(x, y, s, s*1.4, 0, TAU, color(0), 60, 0);

    fill(rcol());
    ellipse(x, y, s, s);


    arc2(x, y, 0, s, 0, TAU, rcol(), 0, 20);

    int div = int(random(16, 69));
    float da = TWO_PI/div;
    float amp = random(0.4, 0.6);
    float ang = random(TWO_PI);
    int c1 = rcol();
    int c2 = rcol();
    for (int j = 0; j < div; j++) {
      fill(c1);
      arc(x, y, s, s, ang+da*j, ang+da*(j+amp));
      arc2(x, y, 0, s, ang+da*j, ang+da*(j+amp), c2, 0, 20);
    }

    float ss = s*random(0.2);

    arc2(x, y, 0, ss*random(2, 3), 0, TAU, color(0), 20, 0);
    fill(rcol());
    ellipse(x, y, ss, ss);
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

//int colors[] = {#FACD00, #FB4F00, #F277C5, #7D57C6, #00B187, #3DC1CD};
int colors[] = {#F19617, #251207, #15727F, #CEAB81, #BD3E36};

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