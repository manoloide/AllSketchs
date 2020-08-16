int paleta[] = {
  #ffcb36, 
  #f19ca9, 
  #aca7cd, 
  #e8314f, 
  #79b2e3
};

PImage img;

void setup() {
  size(800, 800);
  img = loadImage("ref2.jpg");
  generate();
}

void draw() {
}

void keyPressed() {
  if (key == 's') saveImage();
  else generate();
}

void generate() {
  background(rcol());
  stroke(255, 100);
  int ss = int(random(10, 40));
  strokeWeight(ss*random(0.2, 0.4));
  for (int i = 0; i < width+height; i+=ss) {
    line(i, -2, -2, i);
  }

  translate(width/2, height/2);

  int cc = int(random(1, 14));
  for (int c = 0; c < cc; c++) {
    filter(BLUR, random(1.6));
    rotate(random(TWO_PI));
    int r = int(random(2));
    if (r < 1) {
      float sep = random(10, 100);
      int ccc = (width+height);
      float tt = random(1, 5);
      noStroke();
      for (int j = -ccc; j < ccc; j+=ss) {
        for (int i = -ccc; i < ccc; i+=ss) {
          fill(rcol());
          ellipse(i, j, tt, tt);
        }
      }
    } else {
      boolean two = (random(1) < 0.4)? true : false; 
      float sep = random(10, 100);
      int ccc = (width+height);
      float diag = dist(0, 0, width, height);
      strokeWeight(random(1, 5));
      for (int j = -ccc; j < ccc; j+=ss) {
        stroke(rcol(), (random(1) < 0.5)? random(256) : 255);
        line(j, -diag, j, diag);
        line(-diag, j, diag, j);
      }
    }
  }
}

int rcol() {
  int x = int(random(img.width));
  int y = int(random(img.height));
  return img.get(x, y);
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

