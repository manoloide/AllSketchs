void setup() {
  size(960, 960, P2D);
  smooth(8);
  pixelDensity(2);
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

class Rect {
  float x, y, w, h;
  Rect(float xx, float yy, float ww, float hh) {
    this.x = xx;
    this.y = yy;
    this.w = ww;
    this.h = hh;
  }
}

void generate() {

  background(getColor(random(colors.length)));
  background(0);
  //exp = random(0, 1);
  noStroke();

  ArrayList<Rect> rects = new ArrayList<Rect>();
  rects.add(new Rect(0, 0, width, height));

  int div = 0;//int(random(random(1, 10)));
  for (int i = 0; i < div; i++) {
    int ind = int(random(rects.size()*random(1)));
    Rect r = rects.get(ind);
    if (random(1) > 0.5) {
      if (r.w+random(-1, 1) > r.h) {
        rects.add(new Rect(r.x, r.y, r.w*0.5, r.h));
        rects.add(new Rect(r.x+r.w*0.5, r.y, r.w*0.5, r.h));
      } else {
        rects.add(new Rect(r.x, r.y, r.w, r.h*0.5));
        rects.add(new Rect(r.x, r.y+r.h*0.5, r.w, r.h*0.5));
      }
    } else {
      rects.add(new Rect(r.x, r.y, r.w*0.5, r.h*0.5));
      rects.add(new Rect(r.x+r.w*0.5, r.y, r.w*0.5, r.h*0.5));
      rects.add(new Rect(r.x+r.w*0.5, r.y+r.h*0.5, r.w*0.5, r.h*0.5));
      rects.add(new Rect(r.x, r.y+r.h*0.5, r.w*0.5, r.h*0.5));
    }
    rects.remove(ind);
  }

  rectMode(CENTER);
  for (int k = 0; k < rects.size(); k++) {
    Rect r = rects.get(k);
    stroke(0, 4);
    fill(getColor(random(colors.length)));
    float cx = r.x+r.w*0.5;
    float cy = r.y+r.h*0.5;
    float sub = int(random(1, 80));
    float ic = random(colors.length);
    float dc = 3+random(0.05);
    dc = random(colors.length*2.0);
    float exp = random(0.5, 1);
    for (int j = 0; j < sub; j++) {
      float sca = 1.-pow(j/sub, exp);
      fill(getColor(dc*j+ic));
      rect(cx, cy, r.w*sca, r.h*sca);
    }
    noStroke();
    beginShape();
    fill(0, 90);
    vertex(cx, cy);
    fill(0, 0);
    vertex(r.x, r.y+r.h);
    vertex(r.x+r.w, r.y+r.h);
    endShape(CLOSE);
    beginShape();
    fill(0, 50);
    vertex(cx, cy);
    fill(0, 10);
    vertex(r.x+r.w, r.y);
    vertex(r.x+r.w, r.y+r.h);
    endShape(CLOSE);
    beginShape();
    fill(0, 60);
    vertex(cx, cy);
    fill(0, 0);
    vertex(r.x, r.y);
    vertex(r.x, r.y+r.h);
    endShape(CLOSE);
    beginShape();
    fill(0, 30);
    vertex(cx, cy);
    fill(0, 0);
    vertex(r.x, r.y);
    vertex(r.x+r.w, r.y);
    endShape(CLOSE);
  }

  stroke(0, 4);
  for (int k = 0; k < rects.size(); k++) {
    Rect r = rects.get(k);
    float cx = r.x+r.w*0.5;
    float cy = r.y+r.h*0.5;
    float ms = random(0.05, 0.5);
    int cc = int(random(10, 30));
    for (int j = 0; j < cc; j++) {
      int sub = int(random(20, random(20, 220)));
      float ss = r.h*1./sub;
      float exp = random(1, 50);
      float ic = random(colors.length);
      float dc = 3+random(0.03);//random(colors.length*2);//

      float w1 = random(ms*0.05, ms);
      float w2 = random(ms*0.05, ms);
      float h1 = random(ms*0.05, ms);
      float h2 = random(ms*0.05, ms);
      float x1 = r.x+r.w*random(random(0.5), random(0.5, 1));
      float x2 = r.x+r.w*random(random(0.5), random(0.5, 1));
      float y1 = r.y+r.h*random(random(0.5), random(0.5, 1));
      float y2 = r.y+r.h*random(random(0.5), random(0.5, 1));

      rectMode(CENTER);
      for (int i = 0; i < sub; i++) {
        float ww = r.w*map(i, 0, sub-1, w1, w2);
        float hh = r.h*map(i, 0, sub-1, h1, h2);
        float xx = map(i, 0, sub-1, x1, x2);
        float yy = map(i, 0, sub-1, y1, y2);
        fill(getColor(dc*i+ic));
        rect(xx, yy, ww, hh);
      }
    }
  }

  /*
  float ms = random(0.4);
   for (int j = 0; j < 200; j++) {
   int sub = int(random(4, random(4, 120)));
   float ss = height*1./sub;
   float exp = random(1, 50);
   float ic = random(colors.length);
   float dc = 3+random(0.03);//random(colors.length*2);//
   
   float w1 = width*random(ms*0.2, ms);
   float w2 = width*random(ms*0.2, ms);
   float h1 = random(0.2, 4);
   float h2 = random(0.2, 4);
   float x1 = width*random(random(0.5), random(0.5, 1));
   float x2 = width*random(random(0.5), random(0.5, 1));
   float y1 = height*random(random(0.5), random(0.5, 1));
   float y2 = height*random(random(0.5), random(0.5, 1));
   
   rectMode(CENTER);
   for (int i = 0; i < sub; i++) {
   float ww = map(i, 0, sub-1, w1, w2);
   float hh = map(i, 0, sub-1, h1, h2);
   float xx = map(i, 0, sub-1, x1, x2);
   float yy = map(i, 0, sub-1, y1, y2);
   fill(getColor(dc*i+ic));
   rect(xx, yy, ww, ww*hh);
   }
   }
   */

  /*
  for (int i = 0; i < sub; i++) {
   float y1 = map(pow((i*1.)/sub, exp), 0, 1, 0, width);
   float y2 = map(pow((i+1.)/sub, exp), 0, 1, 0, width);
   float ww = map(i, 0, sub-1, w1, w2);
   float hh = map(i, 0, sub-1, h1, h2);
   float xx = map(i, 0, sub-1, x1, x2);
   fill(getColor(dc*i+ic));
   rect(xx-ww*0.5, y1-ww*hh, ww, ww*hh*1.1, ww*0.02, ww*0.02, 0, 0);
   rect(0, y1, width, y2-y1);
   }
   */
}

int colors[] = {#EBB858, #EEA8C1, #D0CBC3, #87B6C4, #EA4140, #5A5787};//, #D0CBC3, #87B6C4, #EA4140, #5A5787};
int rcol() {
  return colors[int(random(colors.length))];
};
int getColor(float v) {
  v = v%(colors.length);
  int c1 = colors[int(v%colors.length)];
  int c2 = colors[int((v+1)%colors.length)];
  float m = v%1;
  return lerpColor(c1, c2, m);
}