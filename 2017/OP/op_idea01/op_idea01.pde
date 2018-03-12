void setup() {
  size(960, 960);
  smooth(8);
  rectMode(CENTER);
  generate();
}


void draw() {
  //if (frameCount%30 == 0) generate();
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
  background(128);

  int cc = int(random(10, 60));
  float ss = width*1./cc;

  float det = random(0.02);
  int sub = 20;//int(random(8, 12));
  for (int j = 0; j < cc+1; j++) {
    for (int i = 0; i < cc+1; i++) {
      float x = (i+0.5)*ss;
      float y = (j+0.5)*ss;

      float ang = noise(x*det, y*det)*2*TWO_PI;
      float d = ss;
      float da = TWO_PI/sub;
      float dc = 255./sub*2;

      noStroke();
      fill(255);
      for (int k = 0; k < sub; k++) {
        float a1 = (k-0.5)*da+ang;
        float a2 = (k+0.5)*da+ang+0.05;
        float col = abs(k-sub/2)*dc;
        //if (kk == 1) col = 255-col;
        fill(col);
        arc(x, y, d, d, a1, a2);
      }
    }
  }
}

int colors[] = {#fe435b, #19b596, #9061bf, #e0dc3f};
int rcol() {
  return colors[int(random(colors.length))];
};