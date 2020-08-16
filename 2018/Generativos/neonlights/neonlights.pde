int seed = int(random(999999));

void setup() {
  size(960, 960, P3D);
  smooth(8);
  pixelDensity(2);
  generate();
}

void draw() {
  //if (frameCount%60 == 0) generate();
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

void generate() {

  background(rcol());

  /*
  hint(DISABLE_DEPTH_TEST);
   beginShape();
   fill(rcol());
   vertex(0, 0);
   vertex(width, 0);
   fill(rcol());
   vertex(width, height);
   vertex(0, height);
   endShape(CLOSE);
   hint(ENABLE_DEPTH_TEST);
   */
  /*
  ortho();
   translate(width/2, height/2, -1000);
   rotateX(HALF_PI-atan(1/sqrt(2)));
   rotateZ(-HALF_PI*0.5);
   */
  float fov = PI/random(1, 1.8);
  float cameraZ = (height/2.0) / tan(fov/2.0);
  perspective(fov, float(width)/float(height), 
    cameraZ/100.0, cameraZ*100.0);
  //ortho();
  translate(width/2, height/2, -20);
  rotateX(PI*random(-0.1, 0.1));
  rotateZ(random(TAU));

  ArrayList<Rect> rects = new ArrayList<Rect>();
  rects.add(new Rect(-width*3, -height*3, width*6, height*6));

  int sub = int(random(50000)*random(1));
  for (int i = 0; i < sub; i++) {
    int ind = int(random(rects.size()*random(1)));
    Rect r = rects.get(ind);
    //if (sep <= r.w || sep <= r.h) continue;
    float nw = r.w/2.;//int(random(1, r.w/sep))*sep;
    float nh = r.h/2.;//int(random(1, r.h/sep))*sep;
    rects.add(new Rect(r.x, r.y, nw, nh));
    rects.add(new Rect(r.x+nw, r.y, r.w-nw, nh));
    rects.add(new Rect(r.x+nw, r.y+nh, r.w-nw, r.h-nh));
    rects.add(new Rect(r.x, r.y+nh, nw, r.h-nh));
    rects.remove(ind);
  }



  for (int i = 0; i < rects.size(); i++) {
    Rect r = rects.get(i);
    stroke(0, 8);
    fill(rcol());
    rect(r.x, r.y, r.w, r.h);
    pushMatrix();
    translate(0, 0, 0.1);
    quad(r.x, r.y, r.w, r.h, rcol(), 120, 0);
    popMatrix();
    int rnd = int(random(3));
    if (rnd == 0) {
      int cc = int(random(1, 10));
      noStroke();
      float ss = min(r.w, r.h)*random(0.8);
      float dd = ss/cc;
      for (int j = 1; j <= cc; j++) {
        pushMatrix();
        translate(r.x+r.w*0.5, r.y+r.h*0.5, j*dd);
        arc2(0, 0, ss, ss*0.5, 0, TAU, rcol(), 60, 0);
        popMatrix();
      }
    }
    if (rnd == 1) {
      float ss = min(r.w, r.h)*random(0.8);
      float hh = min(r.w, r.h)*5;
      pushMatrix();
      translate(r.x+r.w*0.5, r.y+r.h*0.5, hh*0.5);
      fill(rcol());
      box(ss, ss, hh, rcol(), rcol());
      popMatrix();
    }
  }
}

void box(float w, float h, float d, int c1, int c2) {
  float mw = w*0.5;
  float mh = h*0.5; 
  float md = d*0.5;

  /*
  fill(c1);
   beginShape();
   vertex(-mw, -mh, -md);
   vertex(+mw, -mh, -md);
   vertex(+mw, +mh, -md);
   vertex(-mw, +mh, -md);
   endShape();
   */

  fill(c2);
  beginShape();
  vertex(-mw, -mh, +md);
  vertex(+mw, -mh, +md);
  vertex(+mw, +mh, +md);
  vertex(-mw, +mh, +md);
  endShape();

  beginShape();
  fill(c1);
  vertex(-mw, -mh, -md);
  vertex(+mw, -mh, -md);
  fill(c2);
  vertex(+mw, -mh, +md);
  vertex(-mw, -mh, +md);
  endShape();

  beginShape();
  fill(c1);
  vertex(+mw, -mh, -md);
  vertex(+mw, +mh, -md);
  fill(c2);
  vertex(+mw, +mh, +md);
  vertex(+mw, -mh, +md);
  endShape();

  beginShape();
  fill(c1);
  vertex(-mw, +mh, -md);
  vertex(+mw, +mh, -md);
  fill(c2);
  vertex(+mw, +mh, +md);
  vertex(-mw, +mh, +md);
  endShape();

  beginShape();
  fill(c1);
  vertex(+mw, -mh, -md);
  vertex(-mw, -mh, -md);
  fill(c2);
  vertex(-mw, -mh, +md);
  vertex(+mw, -mh, +md);
  endShape();

  beginShape();
  fill(c1);
  vertex(-mw, -mh, -md);
  vertex(-mw, +mh, -md);
  fill(c2);
  vertex(-mw, +mh, +md);
  vertex(-mw, -mh, +md);
  endShape();
}

void arc2(float x, float y, float s1, float s2, float a1, float a2, int col, float alp1, float alp2) {
  float r1 = s1*0.5;
  float r2 = s2*0.5;
  float amp = (a2-a1);
  float ma = map(amp, 0, TWO_PI, 0, 1);
  int cc = max(1, int(max(r1, r2)*PI*ma));
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

void quad(float xx, float yy, float ww, float hh, int col, float alp1, float alp2) {
  beginShape();
  fill(col, alp1);
  vertex(xx, yy);
  vertex(xx+ww, yy);
  fill(col, alp2);
  vertex(xx+ww, yy+hh);
  vertex(xx, yy+hh);
  endShape(CLOSE);
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

//int colors[] = {#E70012, #D3A100, #017160, #00A0E9, #072B45};
//int colors[] = {#2E0551, #FF00C7, #01AFC2, #FDBE03, #F4F9FD};
//int colors[] = {#CD0181, #F56E99, #F4AFB2, #85D4D1, #0055BF};
int colors[] = {#201754, #4C4AC4, #56A3F7, #E0F1FD};
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