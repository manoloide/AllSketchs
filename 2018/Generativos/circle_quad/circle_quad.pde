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

void generate() {
  background(0);

  int cc = int(random(2, random(10, 24)));
  float ss = width*1./cc;

  noStroke();
  for (int j = 0; j < cc; j++) {
    for (int i = 0; i < cc; i++) {
      int c1 = getColor();
      int c2 = getColor();
      float x1 = i*ss;
      float y1 = j*ss;
      float x2 = x1 + ss;
      float y2 = y1 + ss;
      boolean hor = (random(1) < 0.5);
      beginShape();
      fill(c1);
      vertex(x1, y1);
      if (!hor) fill(c2);
      vertex(x2, y1);
      fill(c2);
      vertex(x2, y2);
      if (!hor) fill(c1);
      vertex(x1, y2);
      endShape(CLOSE);

      c1 = color(random(100), random(180));
      c2 = color(random(100), random(180));
      beginShape();
      fill(c2);
      vertex(x1, y1);
      if (!hor) fill(c1);
      vertex(x2, y1);
      fill(c1);
      vertex(x2, y2);
      if (!hor) fill(c2);
      vertex(x1, y2);
      endShape(CLOSE);

      float alp1 = random(80, 140);
      float alp2 = random(80, 100);
      float alp3 = random(50);
      /*/*
       alp1 = 200;
       alp2 = 100;
       alp3 = 40;
       */

      float mix = random(1);

      arc1(x1, y1, 0, ss, 0, HALF_PI, getColor(), alp1, alp2, alp3);
      arc1(x2, y1, 0, ss, HALF_PI, PI, getColor(), alp1, alp2, alp3);
      arc1(x2, y2, 0, ss, PI, PI*1.5, getColor(), alp1, alp2, alp3);
      arc1(x1, y2, 0, ss, PI*1.5, TAU, getColor(), alp1, alp2, alp3);
      //rect(i*ss, j*ss, ss, ss);
    }
  }

  for (int j = 0; j <= cc+1; j++) {
    for (int i = 0; i <= cc+1; i++) {
      float x1 = (i-1)*ss;
      float y1 = (j-1)*ss;
      arc2(x1, y1, 0, ss, 0, TAU, rcol(), 250, 0);
      arc2(x1, y1, ss, 0, 0, TAU, rcol(), 50, 0);

      arc2(x1+ss*0.5, y1+ss*0.5, ss*2, 0, 0, TAU, rcol(), random(40)*random(1), 0);
      arc2(x1+ss*0.5, y1+ss*0.5, ss, 0, 0, TAU, rcol(), random(120)*random(1), 0);

      arc2(x1+ss*0.5, y1+ss*0.5, ss*0.41, 0, 0, TAU, rcol(), 50, 0);
      arc2(x1+ss*0.5, y1+ss*0.5, ss*0.41, 0, 0, TAU, rcol(), 0, random(200)*random(0.5, 1));

      pyram(x1-ss*0.5, y1-ss*0.5, ss, ss, rcol(), rcol(), random(120), random(120));
    }
  }
}

void  pyram(float x, float y, float ww, float hh, int c1, int c2, float alp1, float alp2) {
  float cx = x+ww*0.5;
  float cy = y+hh*0.5;
  beginShape(); 
  fill(c1, alp1);
  vertex(x, y);
  vertex(x+ww, y);
  fill(c2, alp2);
  vertex(cx, cy);
  endShape();

  beginShape(); 
  fill(c1, alp1);
  vertex(x+ww, y);
  vertex(x+ww, y+hh);
  fill(c2, alp2);
  vertex(cx, cy);
  endShape();

  beginShape(); 
  fill(c1, alp1);
  vertex(x+ww, y+hh);
  vertex(x, y+hh);
  fill(c2, alp2);
  vertex(cx, cy);
  endShape();

  beginShape(); 
  fill(c1, alp1);
  vertex(x, y+hh);
  vertex(x, y);
  fill(c2, alp2);
  vertex(cx, cy);
  endShape();
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

void arc1(float x, float y, float s1, float s2, float a1, float a2, int col, float shd1, float shd2, float shd3) {
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
    fill(col, map(abs(sin(i*1./cc*PI)), 0, 1, shd2, shd3));
    vertex(x+cos(ang+da)*r2, y+sin(ang+da)*r2);
    vertex(x+cos(ang)*r2, y+sin(ang)*r2);
    endShape(CLOSE);
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

int colors[] = {#FF18C0, #FF4556, #FF6726, #EFA11C, #B5B346, #DA6548, #3A9FAB};
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