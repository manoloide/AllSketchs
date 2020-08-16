int seed = int(random(999999));

void setup() {
  size(3250, 3250, P2D);
  smooth(2);
  pixelDensity(2);
  generate();
  saveImage();
  exit();
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
  background(rcol());

  int cc = int(random(8, random(20, 120)));
  float ss = width*1./cc;

  noStroke();
  rectMode(CENTER);
  for (int j = 0; j <= cc; j++) {
    for (int i = 0; i <= cc; i++) {
      float xx = i*ss;
      float yy = j*ss;
      fill(rcol());
      ellipse(xx, yy, ss*0.5, ss*0.5);
      fill(rcol());
      //rect(xx, yy, 2, 2);
    }
  }

  float dd = ss*sqrt(2);
  int c = int(cc*cc*random(0.1, 1));
  for (int i = 0; i < c; i++) {
    float xx = int(random(cc))*ss;
    float yy = int(random(cc))*ss; 
    float hh = int(random(2, cc*0.5))*ss;
    float a1 = int(random(4))*HALF_PI;
    float a2 = a1+((random(1) < 0.5)? PI*0.25 : PI*-0.25);
    beginShape();
    fill(rcol());
    vertex(xx, yy);
    vertex(xx+cos(a2)*dd, yy+sin(a2)*dd);
    fill(rcol());
    vertex(xx+cos(a1)*hh+cos(a2)*dd, yy+sin(a1)*hh+sin(a2)*dd);
    vertex(xx+cos(a1)*hh, yy+sin(a1)*hh);
    endShape();
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

int colors[] = {#01903B, #FEE643, #F3500A, #0066B8, #583106, #F4EEE0};
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