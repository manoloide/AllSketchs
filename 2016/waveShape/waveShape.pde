void setup() {
  size(720, 480);
}


void draw() {
  background(240);
  beginShape();
  noFill();
  for (int i = 0; i < width; i++) {
    vertex(i, osc((i+frameCount)*0.02, map(mouseX, 0, width, 0, 5))*-height*0.2+height/2);
  }
  endShape();
}





float osc(float v, float m) {
  m %= 4;
  v %= 1;
  float saw = v;
  float sqr = (v < 0.5)? 0 : 1;
  float sin = abs(sin(v*TWO_PI));
  float tri = abs(v*2-1);

  float res = 0;
  if (m < 1) res = lerp(saw, sqr, m%1);
  else if (m < 2) res = lerp(sqr, sin, m%1);
  else if (m < 3) res = lerp(sin, tri, m%1);
  else if (m < 4) res = lerp(tri, saw, m%1);
  return res;
}