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

  background(lerpColor(rcol(), 220, 0.2));
  noStroke();
  rectMode(CENTER);
  int cc = 32;
  float ss = width*1./cc;
  for (int j = 0; j <= cc; j++) {
    for (int i = 0; i <= cc; i++) {
      fill(0, 20);
      rect(i*ss, j*ss, int(ss*1.02), int(ss*1.02)); 
      fill(230, 80);
      rect(i*ss, j*ss, int(ss*0.3), int(ss*0.3));
    }
  }

  float sub = 5;
  float des = random(1); 
  float det = random(0.01);
  for (int j = 0; j <= cc*sub; j++) {
    for (int i = 0; i <= cc*sub; i++) {
      float ns = ss*1./sub;
      fill(0, 40);
      float s2 = int(ns*0.4*noise(des+det*i, des+det*j));
      rect(i*ns, j*ns, s2, s2);
      fill(230);
      rect(i*ss, j*ss, int(ss*0.1), int(ss*0.1));
    }
  }

  fill(255, 40);
  rects(ss/sub, ss/sub*0.1, 100);

  for (int j = 0; j < 100; j++) {
    float x = random(width);
    float y = random(height);

    x -= x%ss;
    y -= y%ss;

    strokeWeight(ss*0.04);
    stroke(80);
    strokeCap(ROUND);
    for (int i = 0; i < (cc*cc)*0.04; i++) {
      float ax = x;
      float ay = y;
      if (random(1) < 0.5) {
        x += ss*(1-int(random(2))*2); 
        y += ss*(1-int(random(2))*2);
      }

      line(x+0.5, y+0.5, ax+0.5, ay+0.5);
    }
  }

  for (int i = 0; i < 6; i++) {
    float xx = random(width);
    float yy = random(height);
    xx -= xx%ss;
    yy -= yy%ss;

    noStroke();
    arc2(xx+0.5, yy+0.5, ss*0.2, ss, 0, TAU, rcol(), 80, 0);
  }

  for (int i = 0; i < 80; i++) {
    float xx = random(width);
    float yy = random(height);
    xx -= xx%ss;
    yy -= yy%ss;

    float s3 = ss*(int(random(1, random(1, 8))));//+0.5);
    fill(rcol());
    diamont(xx+0.5, yy+0.5, s3);
    if (random(1) < 0.2) {
      fill(rcol());
      diamont(xx+0.5, yy+0.5, s3-8);
    }
    if (random(1) < 0.2) {
      fill(rcol());
      ellipse(xx+0.5, yy+0.5, s3*0.2, s3*0.2);
    }
  }

  for (int j = 0; j <= cc; j++) {
    for (int i = 0; i <= cc; i++) {
      fill(230, 220);
      rect(i*ss, j*ss, int(ss*0.04), int(ss*0.04));
    }
  }


  ArrayList<Rect> rects = new ArrayList<Rect>();
  rects.add(new Rect(width/2, height/2, width-ss*2, height-ss*2));

  int subs = int(random(8, 91));
  for (int i = 0; i < subs; i++) {
    int ind = int(random(rects.size()));
    Rect r = rects.get(ind);
    int ww = int(r.w/ss);
    int hh = int(r.h/ss);
    if (ww <= 2 || hh <= 2) continue;
    int w1 = int(random(1, ww-1));
    int h1 = int(random(1, hh-1));
    int w2 = ww-w1;
    int h2 = hh-h1;
    rects.add(new Rect(r.x-r.w*0.5+w1*ss*0.5, r.y-r.h*0.5+h1*ss*0.5, w1*ss, h1*ss));
    rects.add(new Rect(r.x+r.w*0.5-w2*ss*0.5, r.y-r.h*0.5+h1*ss*0.5, w2*ss, h1*ss));
    rects.add(new Rect(r.x+r.w*0.5-w2*ss*0.5, r.y+r.h*0.5-h2*ss*0.5, w2*ss, h2*ss));
    rects.add(new Rect(r.x-r.w*0.5+w1*ss*0.5, r.y+r.h*0.5-h2*ss*0.5, w1*ss, h2*ss));
    rects.remove(ind);
  }

  strokeWeight(2);
  for (int i = 0; i < rects.size(); i++) {
    if(random(1) < 0.3) continue;
    Rect r = rects.get(i);
    fill(rcol(), 20*random(1));
    stroke(255, 80);
    rect(r.x, r.y, r.w-1, r.h-1, 6);
    stroke(0);
    rect(r.x, r.y, r.w, r.h);
    noStroke();
    fill(255, 80);
    ellipse(r.x+0.5, r.y+0.5, ss*0.5, ss*0.5);
    noStroke();
    float dd = dist(0, 0, r.w, r.h);
    
    arc2(r.x, r.y, dd*0.8, dd, 0, TAU, color(255), 50, 0);
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

void diamont(float x, float y, float s) {
  beginShape();
  vertex(x-s*0.5, y);
  vertex(x, y-s*0.5);
  vertex(x+s*0.5, y);
  vertex(x, y+s*0.5);
  endShape(CLOSE);
}


void rects(float grid, float ss, int cc) {
  for (int i = 0; i < cc; i++) {
    float xx = random(width);
    float yy = random(height);
    xx -= xx%grid;
    yy -= yy%grid;
    rect(xx, yy, ss, ss);
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

int colors[] = {#FB5D40, #D48300, #E5964B, #008172, #165253, #1C1C1A, #D8D8B9};
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
