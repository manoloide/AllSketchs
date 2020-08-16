

int seed = int(random(999999));
float det, des;
PShader post;

void setup() {
  size(640, 360, P3D);
  smooth(8);
  pixelDensity(2);
  post = loadShader("post.glsl");
  generate();
}

void draw() {
  if (frameCount%(30*5) == 0) 
    seed = int(random(999999));
  generate();
  
  saveFrame("export####.png");
  if(frameCount > 30*30) exit();
}

void keyPressed() {
  if (key == 's') saveImage();
  else {
    seed = int(random(999999));
    generate();
  }
}

class Rect {
  float x, y, w, h;
  Rect(float x, float y, float w, float h) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
  }
}

float time;

void generate() {

  time = frameCount/20.;

  des = random(1000);
  det = random(0.001);

  randomSeed(seed);
  background(4, 6, 9);

  ortho();
  lights();

  ArrayList<Rect> rects = new ArrayList<Rect>();
  float sca = 1.8;
  rects.add(new Rect(width*0.5, width*0.5, width*sca, height*sca));

  int sub = int (random(120));
  for (int i = 0; i < sub; i++) {
    int ind = int(random(rects.size())*random(1)*random(0.5, 1));
    Rect r = rects.get(ind);
    int dw = int(random(2, random(10)));
    int dh = int(random(2, random(20)));
    float mw = r.w/dw;
    float mh = r.h/dh;
    for (int dy = 0; dy < dh; dy++) {
      for (int dx = 0; dx < dw; dx++) {
        float ix = dx-dw*0.5+0.5;
        float iy = dy-dh*0.5+0.5;
        rects.add(new Rect(r.x+ix*mw, r.y+iy*mh, mw, mh));
      }
    }
    rects.remove(ind);
  }

  for (int i = 0; i < rects.size(); i++) {
    Rect r = rects.get(i);
    pushMatrix();
    translate(r.x, r.y);
    cylinder(r.w, r.h);
    popMatrix();
  }

  post = loadShader("post.glsl");
  filter(post);
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

void cylinder(float w, float h) {
  int sub = int(random(3, 10));
  int div = int(random(3, 40));
  float rr = w*0.5;
  float da = TWO_PI/div;
  float ww = dist(cos(da)*rr, sin(da)*rr, cos(0)*rr, sin(0)*rr);
  rr = dist(0, 0, (cos(da)*rr+cos(0)*rr)*0.5, (sin(da)*rr+sin(0)*rr)*0.5);
  float hh = h*1.0/sub;
  stroke(255);
  rectMode(CENTER);
  float b = min(ww, hh)*0.05;
  noStroke();
  for (int j = 0; j < sub; j++) {
    float aa = noise(time*random(0.02)*random(1), j)*sub*2;
    float ma = aa%1-0.5;
    float sign = (ma < 0)? -1 : 1;
    aa = aa+(pow(abs(ma), 5)*sign+0.5);
    aa = map(aa, 0, sub, 0, TAU*2);
    float yy = map(j, -0.5, sub-0.5, -h*0.5, h*0.5);
    for (int i = 0; i < div; i++) {
      float ang = da*i+aa;
      float xx = cos(ang)*rr;
      float zz = sin(ang)*rr;

      float tt = time*random(0.1);
      pushMatrix();
      translate(xx, yy, zz);
      rotateY(PI*0.5-ang);
      fill(getColor(time*random(0.5)), pow(noise(tt)*220, 1.2));
      rect(0, 0, ww-b, hh-b);// 5);
      translate(0, 0, 0.5);
      fill(rcol());
      //ellipse(0, 0, min(ww, hh)*0.4, min(ww, hh)*0.4);
      popMatrix();
    }
  }
}

void arc3(float x, float y, float s1, float s2, float a1, float a2, int col, float alp1, float alp2) {
  float r1 = s1*0.5;
  float r2 = s2*0.5;
  float amp = (a2-a1);
  float ma = map(amp, 0, TWO_PI, 0, 1);
  int cc = max(2, int(max(r1, r2)*PI*ma*0.25));
  float da = amp/cc;
  float ic = random(20)+millis()*random(0.01);
  float dc1 = int(random(5))*colors.length*1./cc;
  float dc2 = int(random(5))*colors.length*1./cc;
  for (int i = 0; i < cc; i++) {
    float ang = a1+da*i;
    beginShape();

    fill(getColor(ic+dc1*i), alp1);
    vertex(x+cos(ang)*r1, y+sin(ang)*r1);
    fill(getColor(ic+dc2*i), alp1);
    vertex(x+cos(ang+da)*r1, y+sin(ang+da)*r1);
    fill(getColor(ic+dc2*(i+1)), alp1);
    vertex(x+cos(ang+da)*r2, y+sin(ang+da)*r2);
    fill(getColor(ic+dc1*(i+1)), alp1);
    vertex(x+cos(ang)*r2, y+sin(ang)*r2);
    endShape(CLOSE);
  }
}

void arc2(float x, float y, float s1, float s2, float a1, float a2, int col, float alp1, float alp2) {
  float r1 = s1*0.5;
  float r2 = s2*0.5;
  float amp = (a2-a1);
  float ma = map(amp, 0, TWO_PI, 0, 1);
  int cc = max(2, int(max(r1, r2)*PI*ma*0.25));
  float da = amp/cc;
  for (int i = 0; i < cc; i++) {
    float ang = a1+da*i;
    beginShape();

    fill(col, alp1);
    vertex(x+cos(ang)*r1, y+sin(ang)*r1);
    vertex(x+cos(ang+da)*r1, y+sin(ang+da)*r1);
    fill(col, alp2);
    vertex(x+cos(ang+da)*r2, y+sin(ang+da)*r2);
    vertex(x+cos(ang)*r2, y+sin(ang)*r2);
    endShape(CLOSE);
  }
}

int colors[] = {#016EFF, #FACD3B, #FF26DA, #14164C};
int rcol() {
  return colors[int(random(colors.length))];
}
int getColor() {
  return getColor(random(colors.length));
}
int getColor(float v) {
  v = abs(v);
  v = v%(colors.length);
  int c1 = colors[int(v%colors.length)];
  int c2 = colors[int((v+1)%colors.length)];
  return lerpColor(c1, c2, v%1);
}