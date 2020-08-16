void setup() {
  size(1024, 1024);
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

  int s = 1024/int(pow(2, int(random(2, random(4, 6)))));

  boolean str = random(1) < 0.5;
  if (str) {
    stroke(255);
    noFill();
  } else {
    noStroke();
    fill(255);
  }
  boolean bri = random(1) < 0.5;

  boolean b = random(1) < 0.4;
  float ss = s*random(0.5, 1);
  float bevel = random(0.45);
  strokeWeight(random(0.8, 4));
  for (int i = -s/2; i <= width; i+=s) {
    for (int j = -s/2; j <= height; j+=s) {  
      if (bri) {
        if (str) {
          stroke(random(10, 256));
          noFill();
        } else {
          noStroke();
          fill(random(10, 256));
        }
      }
      if (b) rectBevel(i, j, ss, ss, ss*bevel);
      else cross(i, j, ss, ss, ss*bevel);
    }
  }
}

void rectBevel(float x, float y, float w, float h, float b) {
  x -= w/2;
  y -= h/2;
  beginShape();
  vertex(x, y+b);
  vertex(x+b, y);
  vertex(x+w-b, y);
  vertex(x+w, y+b);
  vertex(x+w, y+h-b);
  vertex(x+w-b, y+h);
  vertex(x+b, y+h);
  vertex(x, y+h-b);
  endShape(CLOSE);
}

void cross(float x, float y, float w, float h, float b) {
  x -= w/2;
  y -= h/2;
  beginShape();
  vertex(x, y+b);
  vertex(x+b, y+b);
  vertex(x+b, y);
  vertex(x+w-b, y);
  vertex(x+w-b, y+b);
  vertex(x+w, y+b);
  vertex(x+w, y+h-b);
  vertex(x+w-b, y+h-b);
  vertex(x+w-b, y+h);
  vertex(x+b, y+h);
  vertex(x+b, y+h-b);
  vertex(x, y+h-b);
  endShape(CLOSE);
}

void grid(float x, float y, float w, float h, float stp) {
  w -= w%stp;
  h -= h%stp;
  for (float i = x; i <= x+w; i+=stp) {
    line(i, y, i, y+h);
  }
  for (float j = y; j <= y+h; j+=stp) {
    line(x, j, x+w, j);
  }
}