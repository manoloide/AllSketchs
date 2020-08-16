int seed = int(random(999999));
float det, des;
PShader post;

void setup() {
  size(960, 960, P2D);
  smooth(8);
  pixelDensity(2);

  //post = loadShader("post.glsl");
  generate();
  /*
  saveImage();
   exit();
   */
}

void draw() {
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

  randomSeed(seed);
  background(0);

  ArrayList<Rect> rects = new ArrayList<Rect>();

  rects.add(new Rect(10, 10, width-20, height-20));

  int sub = int(random(4, 80));
  for (int i = 0; i < sub; i++) {
    int ind = int(random(rects.size()));
    Rect r = rects.get(ind);
    float mw = random(0.2, 0.8);
    float mh = random(0.2, 0.8);
    if (r.w < 40 || r.h < 40) continue;
    rects.add(new Rect(r.x, r.y, r.w*mw, r.h*mh));
    rects.add(new Rect(r.x+r.w*mw, r.y, r.w*(1-mw), r.h*mh));
    rects.add(new Rect(r.x+r.w*mw, r.y+r.h*mh, r.w*(1-mw), r.h*(1-mh)));
    rects.add(new Rect(r.x, r.y+r.h*mh, r.w*mw, r.h*(1-mh)));
    rects.remove(ind);
  }

  fill(255);
  noStroke();
  for (int i = 0; i < rects.size(); i++) {
    Rect r = rects.get(i);
    float xx = r.x+0.5;
    float yy = r.y+0.5;
    float ww = r.w-1;
    float hh = r.h-1;
    fill(getColor());
    rectb(xx, yy, ww, hh, 3);
    
    

    fill(0, 20);
    fill(getColor());
    if(random(1) < 0.8) rectToTri(xx, yy, ww, hh, int(random(4)));
    if (random(1) < 0.1) {
      float rw = ww*random(0.08, 0.4);
      float rh = hh*random(0.4, 0.6);
      float rx = xx+random(ww*0.1, ww*0.9-rw);
      float ry = yy+random(hh*0.1, hh*0.9-rh);
      float ramp = random(0.6, 0.9);
      int sep = int(random(1, random(1, random(12))));
      float nh = rh/sep;
      int col = rcol();
      for (int j = 0; j < sep; j++) {
        fill(0, 40);
        rect(rx+1, ry+1+nh*j, rw, nh*ramp);
        fill(col);
        rect(rx, ry+nh*j, rw, nh*ramp);
      }
    }

    if (random(1) < 0.2) {
      float cs = min(ww, hh)*random(random(0.4, 0.8));
      float cx = random(xx+cs*0.6, xx+ww-cs*0.6);
      float cy = random(yy+cs*0.6, yy+hh-cs*0.6);
      fill(0, 40);
      ellipse(cx+1, cy+1, cs, cs);
      fill(rcol());
      ellipse(cx, cy, cs, cs);
    }

    gradV(xx, yy, ww, hh, rcol(), random(30), rcol(), random(30));
    gradH(xx, yy, ww, hh, rcol(), random(30), rcol(), random(30));

    int cc = int(random(8, 18));
    gridDots(xx, yy, ww, hh, min(ww, hh)*1./cc);
  }




  /*
  post = loadShader("post.glsl");
   filter(post);
   */
}

void gradV(float x, float y, float w, float h, int c1, float a1, int c2, float a2) {
  beginShape();
  fill(c1, a1);
  vertex(x, y);
  vertex(x+w, y); 
  fill(c2, a2);
  vertex(x+w, y+h);
  vertex(x, y+h);
  endShape(CLOSE);
}  
void gradH(float x, float y, float w, float h, int c1, float a1, int c2, float a2) {
  beginShape();
  fill(c1, a1);
  vertex(x, y);
  vertex(x, y+h);
  fill(c2, a2);
  vertex(x+w, y+h);
  vertex(x+w, y); 
  endShape(CLOSE);
} 

void gridDots(float x, float y, float w, float h, float sep) {
  int cw = int(w/sep);
  int ch = int(h/sep);
  float dw = (w-sep*(cw-1))*0.5;
  float dh = (h-sep*(ch-1))*0.5;
  float amp = random(0.2, 0.4);
  float det = random(0.01);
  float des = random(10000);
  for (int j = 0; j < ch-1; j++) {
    for (int i = 0; i < cw-1; i++) {
      float xx = dw+x+(i+0.5)*sep;
      float yy = dh+y+(j+0.5)*sep;
      float ss = (0.9+noise(des+xx*det, des+yy*det)*1.2)*sep*amp;
      fill(255, 40);
      ellipse(xx, yy, ss, ss);
      fill(0, 120);
      ellipse(xx, yy, sep*amp*0.9, sep*amp*0.9); 
      ellipse(xx, yy, sep*amp*0.7, sep*amp*0.7);
    }
  }
}

void rectb(float x, float y, float w, float h, float b) {
  beginShape();
  vertex(x, y+b);
  vertex(x+b, y);
  vertex(x+w-b, y);
  vertex(x+w, y+b);
  vertex(x+w, y+h-b);
  vertex(x+w-b, y+h);
  vertex(x+b, y+h);
  vertex(x, y+h-b);
  endShape(CLOSE);
}

void rectToTri(float x, float y, float w, float h, int dir) {
  beginShape();
  if (dir == 0) {
    vertex(x, y);
    vertex(x+w, y); 
    vertex(x+w*0.5, y+h);
  }
  if (dir == 1) {
    vertex(x+w, y);
    vertex(x+w, y+h); 
    vertex(x, y+h*0.5);
  }
  if (dir == 2) {
    vertex(x, y+h);
    vertex(x+w, y+h); 
    vertex(x+w*0.5, y);
  }
  if (dir == 3) {
    vertex(x, y);
    vertex(x, y+h); 
    vertex(x+w, y+h*0.5);
  }
  endShape(CLOSE);
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

void arc2(float x, float y, float s1, float s2, float a1, float a2, int col, float alp1, float alp2) {
  float r1 = s1*0.5;
  float r2 = s2*0.5;
  float amp = (a2-a1);
  float ma = map(amp, 0, TWO_PI, 0, 1);
  int cc = max(2, int(max(r1, r2)*PI*ma));
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

//int colors[] = {#FF3D20, #FC9D43, #3998C2, #3E56A8, #090D0E};
//int colors[] = {#687FA1, #AFE0CD, #FDECB4, #F63A49, #FE8141};
int colors[] = {#F35A00, #FD9800, #00777F, #703F3B};
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