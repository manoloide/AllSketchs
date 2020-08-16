void setup() {

  size(960, 960);
  generate();
}

void draw() {
}

void keyPressed() {
  if (key == 's') saveImage();
  else generate();
}

void generate() {
  background(180);

  background(250);

  float bb = random(10, 50);
  int rnd = 1;//int(random(4));
  float ss = random(2, 10);

  int cc = int(random(1, 20));

  noFill();
  stroke(0);
  if (rnd == 0) borderSimple(bb, random(1));
  if (rnd == 1) borderLines(bb, ss, cc);
}

void borderSimple(float bb, float sc) {  
  strokeWeight(bb*2);
  rect(0, 0, width, height, bb*sc*2);
}

void borderLines(float bb, float ss, int cc) { 
  strokeWeight(1);
  boolean inv = random(1) < 0.5;
  for (int i = 0; i < cc; i++) {
    float dx = bb+bb*(i+1)*0.4;
    float dy = bb+bb*(i+1)*0.4;
    if (inv) dy = bb+bb*(cc-i+1)*0.4;
    rect(dx, dy, width-dx*2, height-dy*2);
  }
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}