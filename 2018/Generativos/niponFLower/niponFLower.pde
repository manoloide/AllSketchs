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


int back;
void generate() {
  back = rcol();
  background(back);

  float desc = random(10000);
  float detc = random(0.01);
  int cc = 20000;
  noStroke();
  for (int i = 0; i < cc; i++) {
    float x = random(width);
    float dy = pow(map(i, 0, cc, 0.2, 1), 8);
    float y = height*map(dy, 0, 1, 0, 1);
    float s = width*(0.01+random(0.01)*dy);

    fill(getColor(noise(desc+x*detc, desc+y*detc)*colors.length*4));
    ellipse(x, y, s, s);
  }
}


void flower(float x, float y, float s) {
  int c1 = rcol();
  while (c1 == back) c1 = rcol();
  int c2 = rcol();
  while (c2 == back || c2 == c1) c2 = rcol();

  int cc = int(random(3, 20));
  float da = TWO_PI/cc;
  float ang = random(TWO_PI);
  float dir = int(random(2))*2-1;
  pushMatrix();
  translate(x, y);
  fill(c1);
  float s1 = s*random(0.3, 0.45);
  float s2 = s1*random(0.4, 0.8);
  float pwr1 = random(0.5, 1.9);
  float pwr2 = random(0.5, 1.9);
  float dc1 = random(colors.length);
  float dc2 = dc1+random(-1, 1)*random(0.5);
  for (int j = 0; j < cc; j++) {
    pushMatrix();
    rotate(ang+da*j*dir);
    translate(s1*0.5, 0);
    rotate(da*random(-0.04, 0.04));
    rotateX(0.3);
    float ep1 = random(0.95, 1.05);
    float ep2 = random(0.95, 1.05);
    fill(c1);
    petalo(s1, s2, pwr1*ep1, pwr2*ep2, dc1, dc2);
    popMatrix();
  }
  fill(c2);
  translate(0, 0, s*0.5);
  float s3 = s*random(0.18, 0.3);
  ellipse(0, 0, s3, s3);
  popMatrix();
}

void petalo(float s1, float s2, float pwr1, float pwr2, float dc1, float dc2) {
  float r1 = s1*0.5;
  float r2 = s2*0.5;
  float cc = int(TWO_PI*sqrt(((r1*r1)+(r2*r2))/2));
  float da = TWO_PI/cc;
  //ellipse(0, 0, s1, s2);
  beginShape();
  for (int i = 0; i < cc; i++) {
    float ang = da*i;
    float dx = cos(ang);
    float dy = sin(ang);
    dx = sign(dx)*pow(abs(dx), pwr1);
    dy = sign(dy)*pow(abs(dy), pwr2);
    //fill(getColor(map(dx, -1, 1, dc1, dc2)));
    vertex(dx*r1, dy*r2);
  }
  endShape(CLOSE);
}

float sign(float v) {
  if (v > 0) return 1;
  if (v < 0) return -1;
  return 0;
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

//int colors[] = {#FACD00, #FB4F00, #F277C5, #7D57C6, #00B187, #3DC1CD};
int colors[] = {#F19617, #251207, #15727F, #CEAB81, #BD3E36};
//int colors[] = {#FFDA05, #E01C54, #E92B1E, #E94F17, #125FA4, #6F84C5, #54A18C, #F9AB9D, #FFEA9F, #131423};
//int colors[] = {#5C9FD3, #F19DA2, #FEED2D, #9DC82C, #33227E};
//int colors[] = {#FFF050, #0096DB, #FD421A, #6FD551, #FB84A0, #8BC9ED};
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