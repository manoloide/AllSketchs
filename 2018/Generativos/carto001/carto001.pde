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

  background(220);
  noStroke();
  rectMode(CENTER);
  int cc = int(random(8, 33));
  float ss = width*1./cc;
  for (int j = 0; j <= cc; j++) {
    for (int i = 0; i <= cc; i++) {
      fill(0, 20);
      rect(i*ss, j*ss, ss*1.02, ss*1.02); 
      fill(230);
      rect(i*ss, j*ss, ss*0.1, ss*0.1);
    }
  }

  float sub = 5;
  float des = random(1); 
  float det = random(0.01);
  for (int j = 0; j <= cc*sub; j++) {
    for (int i = 0; i <= cc*sub; i++) {
      float ns = ss*1./sub;
      fill(0, 20);
      //rect(i*ns, j*ns, ns*1.02, ns*1.02); 
      fill(230);
      fill(255, 0, 0);
      fill(0, 40);
      float s2 = int(ns*0.5*noise(des+det*i, des+det*j));
      rect(i*ns, j*ns, s2, s2);
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

int colors[] = {#000000, #ffffff, #000000, #ffffff};
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
