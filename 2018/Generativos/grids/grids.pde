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

  rectMode(CENTER);

  for (int i = 0; i < 10000; i++) {
    float x = random(width);
    float y = random(height);
    float r = random(60);
    float a = random(TWO_PI);
    noStroke();
    fill(rcol());
    beginShape();
    float da = TWO_PI/3;
    for (int j = 0; j < 3; j++) {
      vertex(x+cos(a+da*j)*r, y+sin(a+da*j)*r);
    }
    endShape(CLOSE);
  }

  int cc = int(random(1, 7));
  float sss = width*1./cc;
  noStroke();
  for (int j = 0; j < cc; j++) {
    for (int i = 0; i < cc; i++) {
      fill(rcol());
      ellipse(sss*(i+0.5), sss*(j+0.5), sss, sss);
    }
  }

  for (int i = 0; i < 10000; i++) {
    float x = random(width);
    float y = random(height);
    float s = random(20);
    float a1 = random(TWO_PI);
    float a2 = a1+random(HALF_PI);
    stroke(rcol());
    strokeWeight(1);
    noFill();
    arc(x, y, s, s, a1, a2);
  }

  int sub = (int(random(2, random(10, 200*random(1)*random(1))))/2)*2+1;
  float s = width*1./sub;
  float dd = s;  
  strokeWeight(s*random(0.18));

  float des = random(10000);
  float det = random(0.1*random(1));

  float sr = random(0.7, 0.94);
  float sr2 = random(0.1, 1);
  for (int j = 0; j <= sub; j++) {
    for (int i = 0; i <= sub; i++) {
      float x = i*dd;
      float y = j*dd;
      noStroke();
      fill(rcol());
      float ss = s*(0.4+noise(des+x*det, des+y*det)*0.8);
      rrect(x+(dd-ss*sr)*0.5, y+(dd-ss*sr)*0.5, ss*sr, ss*sr, 0.2);
      fill(rcol());
      rrect(x+(dd-ss*sr2)*0.5, y+(dd-ss*sr2)*0.5, ss*sr2, ss*sr2, 0.2);
    }
  }

  float sc1 = (1-sr*0.5)*random(0.7, 0.9);
  float sc2 = random(0.01, 0.2);
  for (int j = 0; j <= sub; j++) {
    for (int i = 0; i <= sub; i++) {
      float x = i*dd;
      float y = j*dd;
      float ss = s*noise(des+x*det, des+y*det);
      noStroke();
      fill(rcol());
      ellipse(x, y, ss*sc2, ss*sc2);
      noFill();
      stroke(rcol());
      ellipse(x, y, ss*sc1, ss*sc1);
    }
  }
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

void rrect(float x, float y, float w, float h, float amp) {
  float mm = min(w, h)*amp;
  beginShape();
  vertex(x, y+mm);
  vertex(x+mm, y);
  vertex(x+w-mm, y);
  vertex(x+w, y+mm);
  vertex(x+w, y+h-mm);
  vertex(x+w-mm, y+h);
  vertex(x+mm, y+h);
  vertex(x, y+h-mm);
  endShape(CLOSE);
}

//int colors[] = {#DF2601, #7A04C4, #1DCCBB, #F4F4F4, #FFD71D};
int colors[] = {#EF7D40, #A071A5, #596FC3, #00BEEE, #F6DFCF};
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