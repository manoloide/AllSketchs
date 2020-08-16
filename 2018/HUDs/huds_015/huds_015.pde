int seed = int(random(999999));

void setup() {
  size(960, 960, P2D);
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
  background(10);//rcol());

  //blendMode(ADD);

  rectMode(CENTER);
  int sc1 = rcol();
  int sc2 = rcol();
  int sc3 = rcol();
  float ss = 40;
  int cc = int(width*1./ss);

  noStroke();
  fill(rcol(), 10);
  for (int j = 0; j <= cc*2; j++) {
    for (int i = 0; i <= cc*2; i++) {
      float xx = (i)*ss*0.5;
      float yy = (j)*ss*0.5;

      rect(xx, yy, 3, 3);
      rect(xx, yy, 1, 1);
      rect(xx+ss*0.25, yy+ss*0.25, 1, 1);
    }
  }

  float alp1 = random(30);
  float alp2 = random(30);
  float alp3 = random(30);
  for (int j = 0; j < cc-1; j++) {
    for (int i = 0; i < cc-1; i++) {
      float xx = (i+1)*ss;
      float yy = (j+1)*ss;
      noFill();
      stroke(sc1, alp1);
      rect(xx, yy, ss, ss); 
      stroke(sc1, alp1*0.3);
      ellipse(xx, yy, ss*0.45, ss*0.45);
      stroke(sc2, alp2);
      rect(xx, yy, ss*0.9, ss*0.9);
      stroke(sc2, alp2*0.3);
      ellipse(xx, yy, ss*0.9, ss*0.9);
      noStroke();
      fill(sc3, alp3);
      rect(xx, yy, ss*0.05, ss*0.05);
    }
  }

  ArrayList<Rect> rects = new ArrayList<Rect>();
  rects.add(new Rect(ss*0.5, ss*0.5, width-ss+1, height-ss+1));

  int dh = int(random(1, 160));
  for (int i = 0; i < dh; i++) {
    int ind = int(random(rects.size()));
    Rect r = rects.get(ind);

    float nh = int(random(1, r.h/ss))*ss;

    if (r.h-nh > ss) {
      rects.add(new Rect(r.x, r.y, r.w, nh));     
      rects.add(new Rect(r.x, r.y+nh, r.w, r.h-nh));
      rects.remove(ind);
    }
  }
  int dw = int(random(1, 140));
  for (int i = 0; i < dw; i++) {
    int ind = int(random(rects.size()));
    Rect r = rects.get(ind);

    float nw = int(random(1, r.w/ss))*ss;

    if (r.w-nw > ss) {
      rects.add(new Rect(r.x, r.y, nw, r.h));     
      rects.add(new Rect(r.x+nw, r.y, r.w-nw, r.h));
      rects.remove(ind);
    }
  }


  for (int k = 0; k < rects.size(); k++) {
    Rect r = rects.get(k);
    float w = r.w;
    float h = r.h;
    float x = r.x;
    float y = r.y;
    fill(rcol(), 180);
    rectMode(CENTER);

    beginShape();
    fill(getColor(), 20);
    vertex(x, y);
    vertex(x+w, y);
    fill(getColor(), 10);
    vertex(x+w, y+h);
    vertex(x, y+h);
    endShape(CLOSE);
    /*
    rect(x, y, w, 2);
     rect(x, y+2, 2, h-2);
     rect(x+w-2, y+2, 2, h-2);
     rect(x+2, y+h-2, w-4, 2);
     */

    int rnd = int(random(3));
    if (rnd == 0) {
      int sca = int(pow(2, int(random(0, 4))));
      int cw = int(w*sca/ss);
      int ch= int(h*sca/ss);
      float sss = ss/sca;
      for (int j = 0; j < ch; j++) { 
        for (int i = 0; i < cw; i++) {
          fill(getColor());
          float xx = x+(i+0.5)*sss;
          float yy = y+(j+0.5)*sss;
          rect(xx, yy, sss*0.8, sss*0.8);
        }
      }
    }
    if (rnd == 1) {
      int sca = int(pow(2, int(random(0, 4))));
      int cw = int(w*sca/ss);
      int ch= int(h*sca/ss);
      if (random(1) <  0.5) cw = 1;
      else ch = 1;
      float ww = w*1./cw;
      float hh = h*1./ch;
      float bb = min(ww, hh)*0.2;
      for (int j = 0; j < ch; j++) { 
        for (int i = 0; i < cw; i++) {
          fill(getColor());
          float xx = x+(i+0.5)*ww;
          float yy = y+(j+0.5)*hh;
          rect(xx, yy, ww-bb, hh-bb);
        }
      }
    }

    if (rnd == 2) {
      float sss = min(w, h)*0.5;
      float s = sss*2-ss*0.2;
      int cw = int(w/min(w, h));
      int ch = int(h/min(w, h));
      float dx = w*0.5;
      float dy = h*0.5;
      if (cw != 1) {
        dx = sss;
        cw = cw*2;
      }
      if (ch != 1) {
        dy = sss;
        ch = ch*2;
      }
      for (int j = 0; j < ch; j++) { 
        float yy = y+j*sss+dy;
        for (int i = 0; i < cw; i++) {
          float xx = x+i*sss+dx;
          fill(getColor(), random(80, 120));
          ellipse(xx, yy, s, s);
        }
      }
    }
  }
}
void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

int colors[] = {#081750, #EB6721, #C4C7DA};
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