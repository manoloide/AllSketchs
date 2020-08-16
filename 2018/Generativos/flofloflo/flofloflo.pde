int seed = int(random(999999));

void setup() {
  size(960, 960, P3D);
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

  ortho();
  ArrayList<PVector> rects = new ArrayList<PVector>();
  rects.add(new PVector(0, 0, width));

  int sub = int(random(10, 300));
  for (int i = 0; i < sub; i++) {
    int ind = int(random(rects.size()*random(1)));
    PVector r = rects.get(ind);
    float sm = r.z*0.5;
    rects.add(new PVector(r.x, r.y, sm));
    rects.add(new PVector(r.x+sm, r.y, sm));
    rects.add(new PVector(r.x+sm, r.y+sm, sm));
    rects.add(new PVector(r.x, r.y+sm, sm));

    rects.remove(ind);
  }

  for (int i = 0; i < rects.size(); i++) {
    PVector r = rects.get(i);
    int s = floor(r.z+0.5);
    int back = rcol();
    /*
    PGraphics gra = createGraphics(s, s, P2D);
     gra.beginDraw();
     gra.noStroke();
     gra.background(back);
     for (int j = 0; j < s*4; j++) {
     float x = random(s);
     float y = random(s);
     float ss = random(s*0.2)*random(0.1, 1);
     gra.fill(lerpColor(back, rcol(), random(0.1)));
     gra.ellipse(x, y, ss, ss);
     }
     gra.endDraw();
     
     image(gra, r.x, r.y, r.z, r.z);
     */
    fill(back);
    rect(r.x, r.y, r.z, r.z);

    int c1 = rcol();
    while (c1 == back) c1 = rcol();
    int c2 = rcol();
    while (c2 == back || c2 == c1) c2 = rcol();

    int cc = int(random(3, 20));
    float da = TWO_PI/cc;
    float ang = random(TWO_PI);
    float dir = int(random(2))*2-1;
    pushMatrix();
    translate(r.x+s*0.5, r.y+s*0.5);
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
      translate(s1*0.5, 0, s*0.5);
      rotate(da*random(-0.04, 0.04));
      rotateX(0.3);
      float ep1 = random(0.95, 1.05);
      float ep2 = random(0.95, 1.05);
      fill(c1);
      petalo(s1, s2, pwr1*ep1, pwr2*ep2, dc1, dc2);
      popMatrix();
    }
    fill(c2);
    translate(0, 0, s);
    float s3 = s*random(0.18, 0.3);
    ellipse(0, 0, s3, s3);
    popMatrix();
  }
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
//int colors[] = {#F19617, #251207, #15727F, #CEAB81, #BD3E36};
int colors[] = {#FFDA05, #E01C54, #E92B1E, #E94F17, #125FA4, #6F84C5, #54A18C, #F9AB9D, #FFEA9F, #131423};
//int colors[] = {#5C9FD3, #F19DA2, #FEED2D, #9DC82C, #33227E};
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