void setup() {
  size(1920, 1920);
  rectMode(CENTER);
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

int colors[] = {#FF1649, #400968, #3AA6D1};
int rcol() {
  return colors[int(random(colors.length))];
};

void generate() {
  background(0);

  translate(width/2, height/2);

  float diag = dist(0, 0, width, height);
  float ss = random(20, 200);
  int cc = ceil(diag/ss)+1;
  rotate(random(TWO_PI));
  noStroke();
  for (int j = -cc/2; j <= cc/2; j++) {
    for (int i = -cc/2; i <= cc/2; i++) {
      //rect(i*ss, j*ss, ss, ss);
      int ccc = int(random(1, 20));
      float dd = (ss/ccc);
      float sss = dd*random(0.5, 0.9);
      float mc = ccc*0.5;
      boolean rnd = (random(1) < 0.5);
      fill(rcol(), random(256));
      for (int dy = 0; dy < ccc; dy++) {
        for (int dx = 0; dx < ccc; dx++) {
          if (rnd) fill(rcol(), random(256));
          float x = i*ss+(dx-mc+0.5)*dd;
          float y = j*ss+(dy-mc+0.5)*dd; 
          rect(x, y, sss, sss);
        }
      }
    }
  }
}