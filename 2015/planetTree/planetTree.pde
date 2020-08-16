int seed = 0;

int amountTree = 1;
float ang = random(TWO_PI);

void setup() {
  size(600, 600);
}

void draw() {
  
  fill(240, 2);
  rect(0, 0, width, height);
  colorMode(HSB, 256, 256, 256, 256);
  fill((frameCount/2.)%256, 200, 200);
  ang += 0.002;
  for (int i = 0; i < amountTree; i++) {
    randomSeed(seed+i*153);
    float r = random(1);
    float aa = ang+(TWO_PI/amountTree)*i;
    float lar = 120*random(0.2, 1);
    tree(width/2, height/2, lar, aa, 12);
  }
  planet(width/2, height/2, 100, 10, ang);
}

void keyPressed() {
  seed++;
  amountTree = int(random(1, 6));
  ang = random(TWO_PI);
}

void tree(float x, float y, float lar, float ang, int c) {
  c--;
  ang += cos(frameCount*0.008)*cos(frameCount*0.0976)*0.4/c;
  float nx = x+cos(ang)*lar;
  float ny = y+sin(ang)*lar;
  noStroke();
  lineWidth(x, y, lar*0.4, nx, ny, lar*0.4*0.6);
  line(x, y, nx, ny);


  if (c > 0) {
    lar *= 0.6;
    float da = (random(1) < 0.5)? -PI/4 : PI/4;
    tree(nx, ny, lar, ang+da, c);
    if (random(1) < 0.5) {
      tree(nx, ny, lar, ang-da, c);
    }
  }
}

void planet(float x, float y, float d, float p, float a) {
  float r = d*0.5;
  float da = TWO_PI/max(p, 3);
  float ang = random(TWO_PI);
  beginShape();
  for (int i = 0; i < max (p, 3); i++) {
    float na = da*(i+random(0.5, 1.5))+a;
    vertex(x+cos(na)*r, y+sin(na)*r);
  }
  endShape(CLOSE);
}

void lineWidth(float x1, float y1, float s1, float x2, float y2, float s2) {
  float ang = atan2(y2-y1, x2-x1);
  beginShape();
  vertex(x1-cos(ang-PI/2)*s1/2, y1-sin(ang-PI/2)*s1/2);
  vertex(x1+cos(ang-PI/2)*s1/2, y1+sin(ang-PI/2)*s1/2);
  vertex(x2+cos(ang-PI/2)*s2/2, y2+sin(ang-PI/2)*s2/2);
  vertex(x2-cos(ang-PI/2)*s2/2, y2-sin(ang-PI/2)*s2/2); 
  endShape(CLOSE);
  ellipse(x2, y2, s2, s2);
}

