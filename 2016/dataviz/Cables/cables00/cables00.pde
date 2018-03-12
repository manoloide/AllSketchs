int seed = int(random(999999));

void setup() {
  size(640, 640);
}


void draw() {
  randomSeed(seed);
  background(234);
  float w = width*0.8;
  float h = height*0.8;
  int cc = 20;
  float x =  (width-w)/2.;
  float y = (height-h)/2.;
  float dy = h/cc;
  fill(40);
  stroke(210);
  strokeWeight(2);
  for (int i = 0; i <= cc; i++) {
    ellipse(x, y+dy*i, 6, 6);
    ellipse(x+w, y+dy*i, 6, 6);
  }

  noFill();
  for (int i = 0; i <= cc*random (0.1, 2); i++) {
    int c1 = int(random(cc+1));
    int c2 = int(random(cc+1));
    float dd = 2;
    stroke(0, 16);
    strokeWeight(3);
    bezier(x, y+dy*c1+dd, x+w*0.5, y+dy*c1+dd, x+w*0.5, y+dy*c2+dd, x+w, y+dy*c2+dd);
    stroke(rcol());
    strokeWeight(2);
    bezier(x, y+dy*c1, x+w*0.5, y+dy*c1, x+w*0.5, y+dy*c2, x+w, y+dy*c2);
  }
}

void keyPressed() {
  if (key == 's') saveImage();
  else seed = int(random(999999));
  //saveFrame("####.png");
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

color rcol() {
  return (random(1) < 0.4)?  color(200, 255, 20) : (random(1) < 0.5)? color(20, 255, 200) : color(255, 20, 200);
}

