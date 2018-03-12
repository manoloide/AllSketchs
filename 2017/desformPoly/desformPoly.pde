void setup() {
  size(720, 720);
}

void draw() {
  background(255); 
  noStroke();
  fill(0);
  int cc = 20;
  for (int i = 0; i < cc; i++) {
    float s = map(i, cos(frameCount*0.31), cc, width*2, 0);
    if (i%2 == 0) fill(0);
    else fill(255);
    poly(width*0.5, height*0.5, s, 5, frameCount*0.02);
  }
}

void poly(float x, float y, float s, int sub, float ang) {
  float r = s*0.5; 
  float da = TWO_PI/sub;
  beginShape();
  float dd = dist(cos(0), sin(0), cos(da), sin(da))*r;
  int s2 = int(dd/2);
  for (int i = 0; i < sub; i++) {
    float a = da*i+ang;
    float x1 = x+cos(a)*r;
    float y1 = y+sin(a)*r; 
    float x2 = x+cos(a+da)*r;
    float y2 = y+sin(a+da)*r; 
    for (int j = 0; j < s2; j++) {
      float xx = map(j, 0, s2, x1, x2);
      float yy = map(j, 0, s2, y1, y2);
      //ellipse(xx, yy, 4, 4);
      PVector d = distor(xx, yy, width/2, height/2, cos(frameCount*0.01)*0.4);
      vertex(d.x, d.y);
    }
  }
  endShape(CLOSE);
}

PVector distor(float x, float y, float cx, float cy, float a) {

  float dd = dist(x, y, width/2, height/2);
  float ang = atan2(cy-y, cx-x);

  ang += cos((dd+a)*0.2)*a;

  return new PVector(cx+cos(ang)*dd, cy+sin(ang)*dd);
}