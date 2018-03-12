ColorRamp cr;

void setup() {
  size(960, 960);
  cr = new ColorRamp();
  cr.addColor(color(#08D9D6), 0.0);
  cr.addColor(color(#252A34), 0.2);
  cr.addColor(color(#FF2E63), 0.6);
  cr.addColor(color(#EAEAEA), 0.85);
  generate();
}

void draw() {
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
  background(0);
  float x = width/2; 
  float y = height/2;
  for (int i = 0; i < 100; i++) {
    float r2 = width*random(0.05, 0.8);
    float r1 = r2*random(1);
    float a1 = random(TWO_PI);
    float a2 = a1+random(TWO_PI);
    int rnd = int(random(3));
    int cc = int(random(3, 100));
    float amp = random(0.2, 0.96);
    noStroke();
    fill(cr.getColor(random(1)), random(255));
    if (rnd == 0) {
      arcy(x, y, r1, r2, a1, a2);
    } else if (rnd == 1) {
      float da = (a2-a1)/cc;  
      r1 = r2*random(0.8, 1); 
      for (int j = 0; j < cc; j++) {
        arcy(x, y, r1, r2, a1+da*j, a1+da*(j+amp));
      }
    } else if (rnd == 2) {
      float prob = random(1);
      cc *= int(random(1, 8));
      float da = TWO_PI/cc;  
      r1 = r2*random(0.8, 1); 
      for (int j = 0; j < cc; j++) {
        if (random(1) > prob)
          arcy(x, y, r1, r2, a1+da*j, a1+da*(j+amp));
      }
    }
  }
}



void arcy(float x, float y, float r1, float r2, float a1, float a2) {

  float tt = a2-a1;
  int cc = int(PI*r2+4);
  float da = tt/cc;
  float xx, yy, ang;
  beginShape();
  for (int i = 0; i < cc; i++) {
    ang = a1+da*i;
    xx = x + cos(ang)*r1;
    yy = y + sin(ang)*r1;
    vertex(xx, yy);
  }
  for (int i = 0; i < cc; i++) {
    ang = a2-da*i;
    xx = x + cos(ang)*r2;
    yy = y + sin(ang)*r2;
    vertex(xx, yy);
  }
  endShape();
}

