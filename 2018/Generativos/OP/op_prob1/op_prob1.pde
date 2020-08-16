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
  background(rcol());

  int cc = int(random(12, 30))*2;
  cc = 30;
  float ss = width*1./cc; 

  noStroke();
  rectMode(CENTER);    
  float des1 = random(10000);
  float det1 = random(0.05);
  float des2 = random(10000);
  float det2 = random(0.05);
  float des3 = random(10000);
  float det3 = random(0.05);
  float des4 = random(10000);
  float det4 = random(0.05);
  for (int j = -1; j <= cc; j++) {
    for (int i = -1; i <= cc; i++) {
      float xx = ss*(i+0.5);
      float yy = ss*(j+0.5);

      if ((i+j)%2 == 0) fill(0);
      else fill(255);
      rect(xx, yy, ss, ss);

      if ((i+j)%2 == 1) fill(0);
      else fill(255);
      if (noise(des1+i*det1, des1+j*det1) < 0.5) rect(xx-ss*0.3, yy-ss*0.3, ss*0.2, ss*0.2);
      if (noise(des2+i*det2, des2+j*det2) < 0.5) rect(xx+ss*0.3, yy-ss*0.3, ss*0.2, ss*0.2);
      if (noise(des3+i*det3, des3+j*det3) < 0.5) rect(xx+ss*0.3, yy+ss*0.3, ss*0.2, ss*0.2);
      if (noise(des4+i*det4, des4+j*det4) < 0.5) rect(xx-ss*0.3, yy+ss*0.3, ss*0.2, ss*0.2);
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

int colors[] = {#E70012, #D3A100, #017160, #00A0E9, #072B45};
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