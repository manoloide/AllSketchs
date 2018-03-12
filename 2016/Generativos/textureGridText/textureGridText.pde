

void setup() {
  size(960, 960);
  textFont(createFont("Chivo-Bold", 96, true));
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
  colorMode(HSB, 360, 100, 100);
  float h = random(360);
  background((h+random(30))%360, 18, 78);

  noStroke();
  fill(h, 60, 100);

  rect(0, 0, 40, height);

  pushMatrix();
  translate(22, height/2);
  rotate(HALF_PI);
  int seed = int(random(999999999));
  textAlign(CENTER, CENTER);
  textSize(32);
  fill(h, 18, 78);
  text("Serie: 1   Seed "+nf(seed, 9), 0, 0);
  fill(h, 18, 78, 30);
  for (int j = 0; j < 8; j++) {
    text("Serie: 1   Seed "+nf(seed, 9), random(-2, 2), random(-2, 2));
  }
  popMatrix();

  textSize(96);
  String letters = "ABCDEFGHIJKLMNÑOPQRSTUVWXYZ";
  float dir = random(TWO_PI);
  for (int j = 1; j< 10; j++) {
    for (int i = 1; i < 10; i++) {
      float x = i*96+26;
      float y = j*96;
      //float s = random(20, 100)*random(1);
      //ellipse(x, y, s, s);
      char let = letters.charAt(int(random(letters.length())));
      if (random(1) < 0.05) let = ' ';
      fill(h, 60, 100, random(210, 256));
      text(let, x, y);

      fill(h, 60, 100, 6);
      float dd = random(80);
      dir = int(random(4))*HALF_PI;
      for (int k = 1; k < dd; k++) {
        float dx = cos(dir)*k;
        float dy = sin(dir)*k;
        text(let, x+dx, y+dy);
      }
    }
  }

  paper(random(2.5, 5));
}

void paper(float d) {
  for (int j = 0; j < height; j++) { 
    for (int i = 0; i < width; i++) {
      color c = get(i, j);
      float v = pow(max(i%d, j%d)/d, 0.9);
      c = lerpColor(c, color(0), v*0.05);
      c = lerpColor(c, color(random(255)), random(0.02)*random(1));
      set(i, j, c);
    }
  }
}