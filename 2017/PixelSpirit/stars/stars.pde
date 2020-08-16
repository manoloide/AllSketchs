void setup() {
  size(960, 960);
  rectMode(CENTER);
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
  background(0);
  star(width/2, height/2, 400, 0.5, int(random(3, 20)), random(TWO_PI));
}

void star(float x, float y, float s, float amp, int cc, float ang) {
  float r1 = s*0.5;
  float r2 = r1*amp;
  float da = TWO_PI/(cc*2); 
  beginShape();
  for (int i = 0; i < cc*2; i++) {
    float a = ang+da*i;
    float r = (i%2== 0)? r1 : r2;
    vertex(x+cos(a)*r, y+sin(a)*r);
  }
  endShape(CLOSE);
}