import peasy.*;

PeasyCam cam;

void setup() {
  size(960, 960, P3D);
  cam = new PeasyCam(this, 500);
  cam.setMinimumDistance(200);
  cam.setMaximumDistance(1000);
}

void draw() {
  background(#8961B4);

  float amp = 120;
  noFill();
  strokeWeight(4);
  stroke(255);
  translate(0, 0, -amp);
  ellipse(0, 0, 500, 500);
  translate(0, 0, amp*2);
  ellipse(0, 0, 500, 500);
  noStroke();
  fill(#FFD374);
  translate(0, 0, -amp);
  ellipse(0, 0, 50, 50);

  int cc = 5;
  float da = TWO_PI/cc;
  noFill();
  stroke(200);
  for (int i = 0; i < cc; i++) {
    beginShape();
    vertex(0, 0, -amp);
    vertex(cos(da*i)*255, sin(da*i)*255, amp);
    endShape();
  }
}