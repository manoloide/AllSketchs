void setup() {
  size(960, 960);
  //pixelDensity(2);
  rectMode(CENTER);
  smooth(8);
  generate();
}

void draw() {
}

void keyPressed() {
  if (key == 's') saveImage();
  else generate();
}

void generate() {
  background(#E0D8D3);

  int dd = int(random(20, 200));
  float ss = dd*random(0.7, 0.95);
  float dx = (width%dd)*0.5;
  float dy = (height%dd)*0.5;

  int cw = width/dd;
  int ch = height/dd;

  fill(0, 2);
  strokeWeight(1);
  stroke(0, 50);
  for (int j = 0; j < ch; j++) {
    for (int i = 0; i < cw; i++) {
      rect(dx+dd*(i+0.5), dy+dd*(j+0.5), ss, ss);
    }
  }

  noStroke();
  float ddd = random(0.3);
  for (int j = 0; j < ch; j++) {
    for (int i = 0; i < cw; i++) {
      pushMatrix();
      translate(dx+dd*(i+0.5+random(-ddd, ddd)), dy+dd*(j+0.5+random(-ddd, ddd)));
      rotate(random(TWO_PI));
      float dx2 = random(ss*0.2*random(1));
      float dy2 = random(ss*0.2*random(1));

      translate(dx2, dy2);
      fill(0, 4);
      for (int k = 12; k > 0; k--) {
        float sss = ss-k;
        rect(0, 0, sss, sss);
      }
      translate(-dx2, -dy2);

      fill(250);
      rect(0, 0, ss, ss);
      popMatrix();
    }
  }

  noisee();
}

void noisee() {
  for (int j = 0; j < height; j++) { 
    for (int i = 0; i < width; i++) {
      float bri = random(-4, 4);
      color col = get(i, j);
      col = color(red(col)+bri, green(col)+bri, blue(col)+bri);
      set(i, j, col);
    }
  }
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}