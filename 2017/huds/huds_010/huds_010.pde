int seed = int(random(9999999));

void setup() {
  size(960, 960, P3D);
  smooth(8);
  pixelDensity(2);
  generate();
}


void draw() {
  //if (frameCount%120 == 0) seed = int(random(9999999));
}

void keyPressed() {
  if (key == 's') saveImage();
  else {
    seed = int(random(9999999));
    generate();
  }
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
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

  background(#0F1316);

  ArrayList<Rect> rects = new ArrayList<Rect>();
  rects.add(new Rect(0, 0, width, height));

  for (int i = 0; i < 100; i++) {
    int ind = int(random(rects.size()));
    Rect r = rects.get(ind);
    int sw = int(random(1, 4));
    int sh = int(random(1, 4));
    float nw = r.w/sw;
    float nh = r.h/sh;
    for (int dy = 0; dy < sh; dy++) {
      for (int dx = 0; dx < sw; dx++) {
        rects.add(new Rect(r.x+dx*nw, r.y+dy*nh, nw, nh));
      }
    }
    rects.remove(ind);
  }

  noStroke();

  int rnd = int(random(3));
  boolean crnd = (random(1) < 0.5);
  //crnd = false;
  //rnd = 2;
  for (int i = 0; i < rects.size(); i++) {
    Rect r = rects.get(i); 

    if (crnd) rnd = int(random(3));

    if (rnd == 0) {  
      noStroke();
      fill(#DBEBF2);
      if (random(1) < 0.5) {
        int cc = int(r.w/6);
        float ss = r.w/cc;
        float pp = random(0.5, 2);
        boolean inv = (random(1) < 0.5);
        for (int j = 0; j < cc; j++) {
          float ww = pow(map(j, 0, cc, 1, 0), pp);
          if (inv) ww = 1-ww;
          rect(r.x+ss*j, r.y, ss*ww, r.h);
        }
      } else {
        int cc = int(r.h/6);
        float ss = r.h/cc;
        float pp = random(0.5, 2);
        boolean inv = (random(1) < 0.5);
        for (int j = 0; j < cc; j++) {
          float hh = pow(map(j, 0, cc, 1, 0), pp);
          if (inv) hh = 1-hh;
          rect(r.x, r.y+ss*j, r.w, ss*hh);
        }
      }
    } else if (rnd == 1) {
      if (random(1) < 0.5) {
        int cc = int(r.h/random(3, 18));
        float ss = r.h/cc;
        for (int j = 0; j < cc; j++) {
          float yy = ss*0.5+r.y+j*ss;
          strokeCap(SQUARE);
          stroke(#DBEBF2, random(80, 250));
          strokeWeight(ss*random(0.6));
          line(r.x, yy, r.x+r.w, yy);
        }
      } else {
        int cc = int(r.w/random(3, 10));
        float ss = r.w/cc;
        for (int j = 0; j < cc; j++) {
          float xx = ss*0.5+r.x+j*ss;
          strokeCap(SQUARE);
          stroke(#DBEBF2, random(80, 250));
          strokeWeight(ss*random(0.6));
          line(xx, r.y, xx, r.y+r.h);
        }
      }
    } else if (rnd == 2) {
      int cc = int(r.h/random(3, 18));
      float ss = r.h/cc;
      float amp = ss*random(3);
      if (random(1) < 0.5) noFill();
      else fill(#DBEBF2);
      strokeWeight(1);
      for (int j = 0; j < cc; j++) {
        float yy = ss*0.5+r.y+j*ss;
        strokeCap(SQUARE);
        stroke(#DBEBF2, random(80, 250));
        beginShape();
        float det = random(2)/ss;
        for (int k = 0; k <= r.w; k++) {
          float xx = r.x+k;
          float dd = fbm(xx*det, yy*det)*amp;
          vertex(xx, yy+dd);
        }
        endShape();
      }
    }
  }

  /*
  fill(0, 2);
   for (int i = 0; i < height; i++) {
   rect(0, i*2, width, 1);
   }
   */
}

float fbm(float x, float y) {   
  float z=2.;
  float rz = 0.;
  float xx = x;
  float yy = y;
  for (float i= 1.; i < 8.; i++)
  {
    rz+= abs((noise(xx, yy)-0.5)*2.)/z;
    z = z*2.;
    xx = xx*2.;
    yy = yy*2.;
  }
  return rz;
}

//https://coolors.co/280f04-e2dcd0-bf1a2b-417f5c-6898c1
int colors[] = {#280f04, #e2dcd0, #bf1a2b, #417f5c, #6898c1};
//int colors[] = {#000000, #FFFFFF, #FF7700, #000000, #15FF4A, #000000, #000000, #BBBBFF};

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