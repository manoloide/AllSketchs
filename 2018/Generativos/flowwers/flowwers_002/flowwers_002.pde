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
  background(#0B0B0B);
  beginShape();
  fill(0, 0);
  vertex(0, 0);
  vertex(width, 0);
  fill(#837954, 40);
  vertex(width, height);
  vertex(0, height);
  endShape(CLOSE);

  noiseSeed(seed);
  randomSeed(seed);

  rectMode(CENTER);
  int c = 20;
  float ss = 60;
  for (int i = 0; i < c; i++) {
    hojas(int(random(80, 400)), width*0.04*map(i, 0, c, 0.2, 1));

    float x = random(width);
    float y = random(height);
    x -= x%ss;
    y -= y%ss;
    float s = width*random(0.7)*random(0.2, 1);
    s -= s%ss;
    noStroke();
    fill(rcol());
    rect(x, y, s, s);
  }
  
  
  for (int i = 0; i < c; i++) {
    float x = random(width);
    float y = random(height);
    x -= x%ss;
    y -= y%ss;
    float s = width*random(0.1)*random(0.2, 1);
    fill(rcol());
    /*
    ellipse(x, y, s, s);
    fill(rcol(), 80);
    ellipse(x, y, s*0.9, s*0.9);
    */
    float a = random(TAU);
    fill(color(0, 150, 60));
    arc(x, y, s, s, a, a+PI*1.8);
    int cd = 100;
    for(int j = 0; j < cd; j++){
      fill(rcol(), random(20));
      float a1 = a+PI*random(0.1, 1.7);
      float a2 = a1+PI*0.1;
      arc(x, y, s, s, a1, a2);
    }
  }


  /*
  int cols[] = {#FED42E, #FF84D4, #FFAFDA, #51B9FF, #2BFF6A};
   for (int i = 0; i < 10; i++) {
   float x = width*random(0.05, 0.95);
   float y = width*random(0.05, 0.95);
   float s = width*random(0.01, 0.04);
   int col = cols[int(random(cols.length))];
   fill(col);
   ellipse(x, y, s, s);
   noStroke();
   arc2(x, y, s, s*3, 0, TAU, col, 50, 0);
   }
   */
}

void hojas(int c, float maxSize) {
  float det1 = random(0.02);
  float des1 = random(1000);
  float det2 = random(0.02);
  float des2 = random(1000);
  float det3 = random(0.02);
  float des3 = random(1000);
  float det4 = random(0.02);
  float des4 = random(1000);

  for (int i = 0; i < c; i++) {
    float x = random(width);
    float y = random(height);
    if (noise(des4+x*det4, des4+y*det4) < 0.5) continue;
    float s = maxSize*pow(noise(des2+x*det2, des2+y*det2), 1.6);//random(0.05, 0.2);
    float a = noise(des1+x*det1, des1+y*det1)*TAU*4;//random(TAU);
    int col = getColor(noise(des3+x*det3, des3+y*det3)*colors.length*2);
    hoja(x, y, s, a, col);
  }
}

void hoja(float x, float y, float s, float ang, int col) {
  float w = s*0.3;
  float h = int(s);
  pushMatrix();
  translate(x, y);
  rotate(ang);
  /*
  line(x, y, x, y-s);
   line(x-w, y-h*0.5, x+w, y-h*0.5);
   */

  float pb = 0.7;
  float px = 2.2;

  noStroke();  
  fill(col);
  for (int i = 0; i < h; i++) {
    float dx1 = sin(pow(map(i, 0, h, 0, 1), pb)*PI)*w;
    float dx2 = sin(pow(map(i+1, 0, h, 0, 1), pb)*PI)*w;
    float dy1 = pow(map(i, 0, h, 0, 1), px)*h;
    float dy2 = pow(map(i+1, 0, h, 0, 1), px)*h;
    fill(lerpColor(col, rcol(), random(0.4)*random(1)));
    beginShape();
    vertex(dx1, -i);
    vertex(dx2, -i-1);
    vertex(0, -dy2);
    vertex(0, -dy1);
    endShape(CLOSE);
  }

  col = lerpColor(col, color(0), 0.2);
  for (int i = 0; i < h; i++) {
    float dx1 = sin(pow(map(i, 0, h, 0, 1), pb)*PI)*-w;
    float dx2 = sin(pow(map(i+1, 0, h, 0, 1), pb)*PI)*-w;
    float dy1 = pow(map(i, 0, h, 0, 1), px)*h;
    float dy2 = pow(map(i+1, 0, h, 0, 1), px)*h;
    fill(lerpColor(col, rcol(), random(0.4)*random(1)));
    beginShape();
    vertex(dx1, -i);
    vertex(dx2, -i-1);
    vertex(0, -dy2);
    vertex(0, -dy1);
    endShape(CLOSE);
  }

  /*
  float px = 2.2;
   for (int i = 0; i <= int(s); i++) {
   float dx = sin(pow(map(i, 0, int(s), 0, 1), pb)*PI)*w;
   float dy = pow(map(i, 0, int(s), 0, 1), px)*int(s);
   stroke(rcol(), random(80));
   line(x, y-dy, x+dx, y-i);
   }
   for (int i = 0; i <= int(s); i++) {
   float dx = sin(pow(map(i, 0, int(s), 0, 1), pb)*PI)*-w;
   float dy = pow(map(i, 0, int(s), 0, 1), px)*int(s);
   stroke(rcol(), random(80));
   line(x, y-dy, x+dx, y-i);
   }
   */

  popMatrix();
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

int colors[] = {#DECFB4, #C0B394, #B0AA7C, #9DA575, #A2A879, #66775D, #45523A, #606B5A, #232D29};
int rcol() {
  return colors[int(random(colors.length))];
}

int getColor(float v) {
  v = abs(v);
  v = v%(colors.length); 
  int c1 = colors[int(v%colors.length)]; 
  int c2 = colors[int((v+1)%colors.length)]; 
  return lerpColor(c1, c2, v%1);
}
