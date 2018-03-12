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
  background(rcol());
  noStroke();
  int cc = int(random(80, 300));
  for (int i = 0; i < cc; i++) {
    float x = random(width); 
    float y = random(height);
    float s = map(pow(map(i, 0, cc, 0, 1), 0.1), 0, 1, 1.6, 0.0)*width*random(0.91, 1.1);
    int c1 = getColor(random(colors.length*1.8));
    int c2 = getColor(random(colors.length*1.8));

    poly(x, y, s, 64, c1, c2);
  }
}

void poly(float x, float y, float s, int res, int c1, int c2) {
  float r = s*0.5; 
  float a = random(TWO_PI); 
  float cr = r*random(0.85); 
  PVector cen = new PVector(x+cos(a)*cr, y+sin(a)*cr); 
  float da = TWO_PI/res; 
  PVector ant, act; 
  for (int i = 1; i <= res; i++) {
    ant = new PVector(x+cos(da*i)*r, y+sin(da*i)*r); 
    act = new PVector(x+cos(da*i+da)*r, y+sin(da*i+da)*r); 
    beginShape(); 
    fill(c1); 
    vertex(ant.x, ant.y); 
    vertex(act.x, act.y); 
    fill(c2); 
    vertex(cen.x, cen.y); 
    endShape();
  }
}

//https://coolors.co/181a99-5d93cc-454593-e05328-34470d
//int colors[] = {#EFF2EF, #9BCDD5, #65C0CB, #308AA5, #308AA5, #85A33C, #F4E300, #E8DBD1, #CE5367, #202219}; 
int colors[] = {#181A99, #5D93CC, #84ACD6, #454593, #E05328, #E27158, #34470D};
int rcol() {
  return colors[int(random(colors.length))];
}
int getColor(float v) {
  v = v%(colors.length); 
  int c1 = colors[int(v%colors.length)]; 
  int c2 = colors[int((v+1)%colors.length)]; 
  return lerpColor(c1, c2, v%1);
}