void setup() {
  size(720, 720);
}

void draw() {
  float time = millis()*0.001;
  background(250);
  noStroke();
  fill(0);
  //ball(width/2, height/2, 160+cos(time*1)*150, cos(time)*0.5+0.5);
  ball(width/2, height/2, 300, cos(time)*0.5+0.5);
}

void ball(float x, float y, float s, float amp) {
  float r = s*0.5;
  float area = PI*r*r;
  int res = int(max(8, (r*PI)*0.25))*2;
  float da = TWO_PI/res;
  float w = s*amp;
  //float h = 
  float ang = millis()*0.001;
  float a1;
  beginShape();
  for (int i = 0; i <= res/2; i++) {
    a1 = ang+da*i+HALF_PI;
    vertex(x+cos(a1)*r-cos(ang)*w*0.5, y+sin(a1)*r-sin(ang)*w*0.5);
  }
  for (int i = res/2; i <= res; i++) {
    a1 = ang+da*i+HALF_PI;
    vertex(x+cos(a1)*r+cos(ang)*w*0.5, y+sin(a1)*r+sin(ang)*w*0.5);
  }
  endShape(CLOSE);
}