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

  float det1 = random(0.02);
  float des1 = random(1000);
  float det2 = random(0.02);
  float des2 = random(1000);

  for (int i = 0; i < 60000; i++) {
    float x = random(width);
    float y = random(height);
    float s = width*0.04*noise(des2+x*det2, des2+y*det2);//random(0.05, 0.2);
    float a = noise(des1+x*det1, des1+y*det1)*TAU*4;//random(TAU);
    stroke(rcol());
    hoja(x, y, s, a);
  }
  
  int cols[] = {#FED42E, #FF84D4, #FFAFDA, #51B9FF, #2BFF6A};
  for(int i = 0; i < 10; i++){
    float x = width*random(0.05, 0.95);
    float y = width*random(0.05, 0.95);
    float s = width*random(0.01, 0.04);
    int col = cols[int(random(cols.length))];
    fill(col);
    ellipse(x, y, s, s);
    noStroke();
    arc2(x, y, s, s*3, 0, TAU, col, 50, 0);
  }  
}

void hoja(float x, float y, float s, float ang) {
  float w = s*0.3;
  float h = s;
  pushMatrix();
  translate(x, y);
  rotate(ang);
  /*
  line(x, y, x, y-s);
  line(x-w, y-h*0.5, x+w, y-h*0.5);
  */

  int col1 = rcol();
  float pb = 0.7;
  
  noStroke();  
  fill(col1);
  beginShape();
  for (int i = 0; i <= int(s); i++) {
    float dx = sin(pow(map(i, 0, int(s), 0, 1), pb)*PI)*w;
    vertex(x+dx, y-i);
  }
  endShape(CLOSE);
  fill(lerpColor(col1, color(0), 0.2));
  beginShape();
  for (int i = 0; i <= int(s); i++) {
    float dx = sin(pow(map(i, 0, int(s), 0, 1), pb)*PI)*-w;
    vertex(x+dx, y-i);
  }
  endShape(CLOSE);
  
  float px = 2.2;
  for (int i = 0; i <= int(s); i++) {
    float dx = sin(pow(map(i, 0, int(s), 0, 1), pb)*PI)*w;
    stroke(rcol(), random(80));
    float dy = pow(map(i, 0, int(s), 0, 1), px)*int(s);
    line(x, y-dy, x+dx, y-i);
  }
  for (int i = 0; i <= int(s); i++) {
    float dx = sin(pow(map(i, 0, int(s), 0, 1), pb)*PI)*-w;
    float dy = pow(map(i, 0, int(s), 0, 1), px)*int(s);
    stroke(rcol(), random(80));
    line(x, y-dy, x+dx, y-i);
  }

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
