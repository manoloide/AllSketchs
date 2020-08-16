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

  background(255);

  randomSeed(seed);
  noStroke();
  beginShape();
  fill(rcol(), 10);
  vertex(0, 0);
  vertex(width, 0);
  fill(rcol(), 10);
  vertex(width, height);
  vertex(0, height);
  endShape();

  noStroke();
  int c = int(random(5000));

  rectMode(CENTER);

  for (int k = 0; k < c; k++) {
    float ss = width*1./floor(pow(2, floor(random(random(1, 7), 7))));
    float xx = random(width+ss); 
    float yy = random(height+ss);

    xx -= xx%ss;
    yy -= yy%ss;

    int rnd = int(random(4));

    if (rnd == 0) {
      noStroke();
      arc2(xx, yy, ss, ss*1.6, 0, TAU, color(0), 10, 0);
      arc2(xx, yy, ss, ss*0.4, 0, TAU, rcol(), 220, 0);
    }
    if (rnd == 1) {
      boolean str = (random(1) < 0.5);
      noStroke();
      noFill();

      if (str) {
        fill(rcol());
        rect(xx-ss*0.5, yy-ss*0.5, ss, ss);
        srect(xx, yy, ss, ss, ss*0.2, rcol(), 80, 0);
      } else {
        float sstr = random(1, 4);
        strokeWeight(sstr);
        stroke(rcol());
        rect(xx-ss*0.5, yy-ss*0.5, ss-sstr, ss-sstr);
        rect(xx-ss*0.5, yy-ss*0.5, ss*0.2, ss*0.2);
      }
    }
    if (rnd == 2) {
      int cc = int(random(2, 7));
      float s = ss/cc;
      noStroke();
      for (int j = 0; j < cc; j++) {
        for (int i = 0; i < cc; i++) {
          fill(rcol());
          rect(xx+s*i, yy+s*j, s*0.8, s*0.8);
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
  int cc = max(4, int(max(r1, r2)*PI*ma));
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

void srect(float x, float y, float w, float h, float bb, int col, float a1, float a2) {
  float mw = w*0.5;
  float mh = h*0.5;
  beginShape();
  fill(col, a1);
  vertex(x-mw, y-mh);
  vertex(x+mw, y-mh);
  fill(col, a2);
  vertex(x+mw+bb, y-mh-bb);
  vertex(x-mw-bb, y-mh-bb);
  endShape(CLOSE);

  beginShape();
  fill(col, a1);
  vertex(x+mw, y-mh);
  vertex(x+mw, y+mh);
  fill(col, a2);
  vertex(x+mw+bb, y+mh+bb);
  vertex(x+mw+bb, y-mh-bb);
  endShape(CLOSE);

  beginShape();
  fill(col, a1);
  vertex(x+mw, y+mh);
  vertex(x-mw, y+mh);
  fill(col, a2);
  vertex(x-mw-bb, y+mh+bb);
  vertex(x+mw+bb, y+mh+bb);
  endShape(CLOSE);

  beginShape();
  fill(col, a1);
  vertex(x-mw, y+mh);
  vertex(x-mw, y-mh);
  fill(col, a2);
  vertex(x-mw-bb, y-mh-bb);
  vertex(x-mw-bb, y+mh+bb);
  endShape(CLOSE);
}

int colors[] = {#FFFCF7, #FDDA02, #EE78AC, #3155A3, #028B88};//int colors[] = {#010187, #0A49FF, #FF854E, #FFCAE3, #FFFFFF};
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