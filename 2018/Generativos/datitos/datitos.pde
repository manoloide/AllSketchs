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
  background(rcol());

  float des1 = random(1000);
  float det1 = random(0.01);
  float des2 = random(1000);
  float det2 = random(0.006);
  float des3 = random(1000);
  float det3 = random(0.01);
  float des4 = random(1000);
  float det4 = random(0.01);

  noStroke();
  for (int i = 0; i < 500; i++) {
    float x = random(width); 
    float y = random(height);
    float d = 1+noise(des2+x*det2, des2+y*det2)*10;
    float n = pow(noise(des1+x*det1*d, des1+y*det1*d), 2);
    float s = width*map(n, 0, 1, 0.0, 0.4);
    float amp = 1+noise(des3+x*det3, des3+y*det3)*1.8;     
    int col = rcol();

    float a = noise(des2+x*det2, des2+y*det2)*TAU*2;


    stroke(255, 4);
    arc2(x, y, s, s*amp, a-0.2, a+0.2, rcol(), 20, 250);
    fill(rcol());
    arc(x, y, s*amp, s*amp, a-0.02, a+0.02);

    arc2(x, y, s, s*amp, 0, TAU, col, 180, 0);
    fill(col, 60);
    ellipse(x, y, s*0.14, s*0.14);
    fill(col);
    ellipse(x, y, s*0.1, s*0.1);

    float a1 = random(TAU);
    float a2 = a1+HALF_PI*random(0.2, 1.2);
    stroke(rcol(), 40);
    arc2(x, y, s*0.6, s*0.95, a1, a2, rcol(), 200, 0);
  }
}

void boxShadow(float w, float h, float b, int col, float alp) {
  float mw = w*0.5;
  float mh = h*0.5;

  beginShape();
  fill(col, alp);
  vertex(-mw, -mh);
  vertex(+mw, -mh);
  fill(col, 0);
  vertex(+mw+b, -mh-b);
  vertex(-mw-b, -mh-b);
  endShape(CLOSE);

  beginShape();
  fill(col, alp);
  vertex(+mw, -mh);
  vertex(+mw, +mh);
  fill(col, 0);
  vertex(+mw+b, +mh+b);
  vertex(+mw+b, -mh-b);
  endShape(CLOSE);

  beginShape();
  fill(col, alp);
  vertex(+mw, +mh);
  vertex(-mw, +mh);
  fill(col, 0);
  vertex(-mw-b, +mh+b);
  vertex(+mw+b, +mh+b);
  endShape(CLOSE);

  beginShape();
  fill(col, alp);
  vertex(-mw, +mh);
  vertex(-mw, -mh);
  fill(col, 0);
  vertex(-mw-b, -mh-b);
  vertex(-mw-b, +mh+b);
  endShape(CLOSE);
}

void plane(float w, float h, int c1, int c2, float alp1, float alp2) {
  float mw = w*0.5;
  float mh = h*0.5;

  beginShape();
  fill(c1, alp1);
  vertex(-mw, -mh);
  vertex(+mw, -mh);
  fill(c2, alp2);
  vertex(+mw, +mh);
  vertex(-mw, +mh);
  endShape(CLOSE);
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
  int cc = max(2, int((max(r1, r2)*PI)*ma));
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


//int colors[] = {#FDFDFD, #BBC9D4, #6CD1B3, #FB7C69, #3A66E3, #0D2443};
int colors[] = {#000000, #33346B, #567BF6, #B4CAFB, #FFFFFF, #FFB72A, #FF4C3D};
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