float[] amp = {0.5, 0.5, 0.5};
int[] seg = {1, 2, 4};

void setup() {
  size(720, 480);
}

void draw() {
  background(#191021);

  for (int i = 0; i <= width; i+=15) {
    if (i%30 == 0 ) stroke(255, 16);
    else stroke(255, 6);
    line(i, 0, i, height);
  }
  for (int i = 0; i <= height; i+=15) {
    if (i%30 == 0 ) stroke(255, 16);
    else stroke(255, 6);
    line(0, i, width, i);
  }

  noStroke();
  fill(255, 128, 0, 60);
  drawFunction2(30, 30, 420, 420);
  drawFunction(480, 30, 210, 120, amp[0], seg[0]);
  drawFunction(480, 180, 210, 120, amp[1], seg[1]);
  drawFunction(480, 330, 210, 120, amp[2], seg[2]);
}


void drawFunction(float x, float y, float w, float h, float amp, int seg) {
  noStroke();
  fill(255, 128, 0, 60);
  rect(x, y, w, h);

  noFill();
  stroke(255, 128, 0);
  beginShape();
  for (int i = 0; i < w; i++) {
    float val = sin(map(i, 0, w, 0, TWO_PI*seg))*h*0.5*amp;
    vertex(x+i, y+h/2+val);
  }
  endShape();
}

void drawFunction2(float x, float y, float w, float h) {
  noStroke();
  fill(255, 128, 0, 60);
  rect(x, y, w, h);

  noFill();
  stroke(255, 128, 0);
  beginShape();
  for (int i = 0; i < w; i++) {
    float val = 0;
    for (int j = 0; j < 3; j++) {
      val +=  sin(map(i, 0, w, 0, TWO_PI*seg[j]))*h*0.5*amp[j];
    }
    vertex(x+i, y+h/2+val);
  }
  endShape();
}