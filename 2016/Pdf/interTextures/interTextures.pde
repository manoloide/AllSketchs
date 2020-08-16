import processing.pdf.*;

void settings() {
  size(1920, 1920, PDF, getTimestamp()+".pdf");
}

void setup() {
}

void draw() {
  background(255);

  rectMode(CENTER);
  noStroke();
  fill(0);

  int minSize = 2;
  int size = 10;
  int sep = 25;

  float det = 0.2/sep;
  for (int j = 0; j <= height; j+= sep) {
    for (int i = 0; i <= width; i+= sep) {
      //if (random(1) > 0.5) continue;
      if (noise(i*det, j*det) > 0.5) continue;
      float ss = noise(i*det, j*det)*size;
      //ss = constrain(ss, minSize, size);
      ss = map(ss, size*0.5, size, 0, size);
      ss = minSize;
      //stroke(0);
      //noFill();
      rect(i, j, ss, ss);
      /*
      noStroke();
      fill(0);
      rect(i, j, minSize, minSize);
      */
    }
  }

  exit();
}

String getTimestamp() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  return timestamp;
}