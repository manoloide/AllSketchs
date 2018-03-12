int seed = int(random(999999));

void setup() {
  size(960, 960, P2D);
  smooth(8);
  pixelDensity(2);
  generate();
}

void draw() {
  //if (frameCount%60 == 0) generate();
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
  seed = int(random(999999));

  randomSeed(seed);
  noiseSeed(seed);

  background(0);
  int ss = 10;

  noStroke();
  fill(255, 18);
  rectMode(CENTER);
  for (int j = 0; j <= height; j+=ss) {
    for (int i = 0; i <= width; i+=ss) {
      rect(i, j, 2, 2);
      if (i%8 == 0 && j%8==0) rect(i, j, 3, 3);
    }
  }

  for (int c = 0; c < 20; c++) {
    float ww = int(random(1, 7))*40;
    float hh = int(random(1, 7))*40;
    float xx = random(width+ww);
    float yy= random(height+hh);
    int dir = int(random(4));
    xx -= xx%40;
    yy -= yy%40;
    int col = rcol();
    float det = random(0.1);
    float sss = random(1, 3.5);
    for (int j = 0; j < hh; j+= 5) {
      for (int i = 0; i < ww; i+= 5) {
        float x = xx+1.5+i;
        float y = yy+1.5+j;
        fill(col, noise(x*det, y*det)*256);
        rect(x, y, sss, sss, 1);
      }
    }
  }

  for (int i = 0; i < 200; i++) {
    float ww = int(random(1, 5))*40;
    float hh = int(random(1, 5))*40;
    float xx = random(-ww, width+ww);
    float yy= random(-hh, height+hh);
    xx -= xx%40;
    yy -= yy%40;

    float b1 = int(random(1, 5))*10;
    float b2 = int(random(1, 5))*10;
    float b3 = int(random(1, 5))*10;
    float b4 = int(random(1, 5))*10;

    strokeWeight(random(1, 2));
    stroke(rcol(), random(256));
    noFill();

    beginShape();
    vertex(xx, yy+b1);
    vertex(xx+b1, yy);
    vertex(xx+ww-b2, yy);
    vertex(xx+ww, yy+b2);
    vertex(xx+ww, yy+hh-b3);
    vertex(xx+ww-b3, yy+hh);
    vertex(xx+b4, yy+hh);
    vertex(xx, yy+hh-b4);
    endShape(CLOSE);
  }

  noStroke();
  for (int i = 0; i < 100; i++) {
    float sss = pow(2, int(random(0, 4)))*10;
    float xx = random(width);
    float yy= random(height);
    xx -= xx%sss;
    yy -= yy%sss;
    //stroke(255, 5);
    fill(rcol(), random(200));
    rect(xx+sss*0.5, yy+sss*0.5, sss-2, sss-2, sss*0.1);
  }
}

int colors[] = {#2D29BB, #D81B00, #FC5D00, #FF6567, #F1F1F1};
int rcol() { 
  return colors[int(random(colors.length))];
};