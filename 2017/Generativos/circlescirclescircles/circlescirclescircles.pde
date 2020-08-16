int seed = int(random(999999));

void setup() {
  size(960, 960, P2D);
  smooth(8);
  pixelDensity(2);
  generate();
}

void draw() {
  //if (frameCount%40 == 0) generate();
}

void keyPressed() {
  if (key == 's') saveImage();
  else generate();
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

void generate() {

  seed = int(random(999999));
  background(getColor(random(colors.length*2)));

  float s = width*random(1, 10);
  float a = random(TWO_PI);
  float x = width/2+cos(a)*s*0.2;  
  float y = height/2+sin(a)*s*0.2;
  noStroke();
  circleRec(x, y, s, 5);
}

void circleRec(float x, float y, float s, int lvl) {
  float r = s*0.3; 
  float ss = r*0.9; 
  fill(getColor(random(colors.length*2)));
  circle(x, y, s);
  fill(0, 20);
  if (lvl <= 0) return;
  int cc = 6; 
  float da = TWO_PI/cc; 
  float a = random(TWO_PI);
  for (int i = 0; i < cc; i++) {
    circleRec(x+cos(a+da*i)*r, y+sin(a+da*i)*r, ss, lvl-1);
  }
}

void circle(float x, float y, float s) { 
  float r = s*0.5;
  int res = 120; 
  float da = TWO_PI/res;
  float a = random(TWO_PI);
  float rr = r*random(0.5, 1)*random(1);
  float aa = random(TWO_PI);
  PVector c = new PVector(cos(aa)*rr, sin(aa)*rr);

  int cc = getColor(random(colors.length*2));

  float ic = random(colors.length*2);
  float dc = random(colors.length*random(1));
  for (int i = 0; i < res; i++) {
    int c1 = getColor(ic+map(abs(i-res*0.5)*2, 0, res, 0, dc));
    int c2 = getColor(ic+map(abs(i-res*0.5+1)*2, 0, res, 0, dc));
    float a1 = da*i+a;
    float a2 = da*(i+0.05)+a+da;
    beginShape();
    fill(c1);
    vertex(x+cos(a1)*r, y+sin(a1)*r);
    fill(c2);
    vertex(x+cos(a2)*r, y+sin(a2)*r);
    fill(cc);
    vertex(x+c.x, y+c.y);
    endShape(CLOSE);
  }
}



int colors[] = {#F8CA9C, #F8B6D9, #EF276B, #A14FBE, #1D43B8};
//int colors[] = {#45171D, #F03861, #FF847C, #FECEA8};
int rcol() {
  return colors[int(random(colors.length))] ;
}
int getColor(float v) {
  v = v%(colors.length);
  int c1 = colors[int(v%colors.length)];
  int c2 = colors[int((v+1)%colors.length)];
  return lerpColor(c1, c2, v%1);
}