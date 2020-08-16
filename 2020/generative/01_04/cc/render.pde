class Rect {
  float x, y, w, h;
  Rect(float x, float y, float w, float h) {
    this.x = x; 
    this.y = y;
    this.w = w; 
    this.h = h;
  }
}
void back() {

  hint(DISABLE_DEPTH_TEST);

  background(230);//255);

  detCol = random(0.002);
  desCol = random(10000);
  detDes = random(0.001, 0.002);
  detDes2 = random(0.001, 0.002);
  desDes = random(10000);

  PVector des = def(0, 0, 0);

  float bb = 10;
  translate(swidth*0.5, sheight*0.5);
  for (int j = 0; j < 1; j++) {
    //stroke(255, 10);
    kkk = random(0.4, 0.6)*random(0.03, 0.04)*random(0.2, 1)*random(0.5, 1)*0.4;
    float w = swidth*2;
    float h = sheight*2;
    form(-des.x+random(-50, 50), -des.y+random(-50, 50), w, h);
  }
}

void form(float x, float y, float w, float h) {

  //forms01(points);
  float s = min(w, h);


  int div = int(random(160, 220)*random(1.8, 2)*(min(w,h)*0.5/sheight));
  float ss = s/div;

  pushMatrix();
  translate(x, y);
  rotate(random(TAU));

  //blendMode(ADD);

  //stroke(rcol());
  //strokeWeight(0.8);
  float ww = ss;//0.8;
  float hh = ss;//0.8;
  noFill();
  for (int i = 0; i <= div; i++) {
    float xx = ww*(i-div*0.5);
    float yy = hh*(i-div*0.5);
    stroke(0, random(25, 35));//230-random(110));
    float amp = random(0.2+random(0.3), 0.5);
    fline(xx, -hh*div*amp, xx, hh*div*amp);
    fline(-ww*div*amp, yy, ww*div*amp, yy);
  }
  popMatrix();
}

void fline(float x1, float y1, float x2, float y2) {
  float dis = dist(x1, y1, x2, y2);
  int res = int(dis*2);
  beginShape();
  for (int i = 0; i <= res; i++) {
    float v1 = i*1./res;
    float v2 = (i+1)*1./res;
    PVector p1 = def(lerp(x1, x2, v1), lerp(y1, y2, v1), 0);
    //PVector p2 = def(lerp(x1, x2, v2), lerp(y1, y2, v2), 0);
    vertex(p1.x, p1.y);//
    //line(p1.x, p1.y, p1.z, p2.x, p2.y, p2.z);
  }
  endShape();
}

float detCol = random(0.002);
float desCol = random(10000);
float detDes = random(0.001);
float detDes2 = random(0.001);
float desDes = random(10000);

float kkk;
PVector def(float x, float y, float z) {
  //kkk = 0.1;
  //kkk *= 0.004;
  float c = (float) noise(kkk*x, kkk*y)*2-1;
  c *= 1.2;
  float s = (float) noise(0, kkk*x, kkk*y)*2-1;
  float[] m = {c, -s, s, c};
  PVector  q = new PVector(m[0]*x + m[2]*z, y, m[1]*x + m[3]*z);

  q.x += (noise(desDes+detDes*q.x, desDes+detDes*q.y, 999)*2-1)*120;
  q.y += (noise(desDes+detDes*q.x, desDes+detDes*q.y, 111)*2-1)*120;

  q.x += (noise(desDes+detDes2*q.x, desDes+detDes2*q.y, 999)*2-1)*30;
  q.y += (noise(desDes+detDes2*q.x, desDes+detDes2*q.y, 111)*2-1)*30;

  return q;
}
