int seed = int(random(999999));

void setup() {
  size(960, 960, P3D);
  smooth(8);
  pixelDensity(2);
  frameRate(30);
  generate();
}

void draw() {
  //if (frameCount%(25*2) == 0) seed = int(random(999999));
  generate();
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

  ArrayList<Rect> sub() {
    ArrayList<Rect> aux = new ArrayList<Rect>();
    if (min(w, h) < 10) {
      aux.add(this);
      return aux;
    }
    int rnd = ((w > h)? 0 : 2)+int(random(2));
    if (w == h) rnd = int(random(4));
    float mw = w*0.5;
    float mh = h*0.5;
    if (rnd == 0) {
      aux.add(new Rect(x, y, mw, h));
      aux.add(new Rect(x+mw, y, mw, mh));
      aux.add(new Rect(x+mw, y+mh, mw, mh));
    } else if (rnd == 1) {
      aux.add(new Rect(x, y, mw, mh));
      aux.add(new Rect(x, y+mh, mw, mh));
      aux.add(new Rect(x+mw, y, mw, h));
    }
    if (rnd == 2) {
      aux.add(new Rect(x, y, w, mh));
      aux.add(new Rect(x, y+mh, mw, mh));
      aux.add(new Rect(x+mw, y+mh, mw, mh));
    }
    if (rnd == 3) {
      aux.add(new Rect(x, y, mw, mh));
      aux.add(new Rect(x+mw, y, mw, mh));
      aux.add(new Rect(x, y+mh, w, mh));
    }
    return aux;
  }
}

ArrayList<Rect> rects;

void generate() {

  float time = millis()*0.001;

  randomSeed(seed);
  noiseSeed(seed);

  background(20);
  {
    float ss = 15;
    int cw = int(width/ss);
    int ch = int(height/ss);

    rectMode(CENTER);
    noStroke();
    fill(50);
    for (int j = 0; j <= ch; j++) {
      for (int i = 0; i <= cw; i++) {
        rect(i*ss, j*ss, 2, 2);
      }
    }
    rectMode(CORNER);
  }


  rects = new ArrayList<Rect>();
  rects.add(new Rect(0, 0, width, height));
  {
    int div = int(random(2, random(10, 300)));
    for (int i = 0; i < div; i++) {
      int ind = int(random(rects.size()));
      rects.addAll(rects.get(ind).sub());
      rects.remove(ind);
    }
  }


  for (int c = 0; c < rects.size(); c++) {
    Rect r = rects.get(c);
    float bb = 0;
    float xx = r.x+bb;
    float yy = r.y+bb;
    float ww = r.w-bb*2;
    float hh = r.h-bb*2;
    stroke(50);
    noFill();
    rect(r.x, r.y, r.w, r.h);
    int rnd = int(random(4));
    boolean isRect = (abs(ww-hh) < 1);
    if (rnd == 0) {
      stroke(0);
      noStroke();
      fill(10, 160);
      rect(xx, yy, ww, hh);
      float des1 = int(random(10000));
      float det1 = random(4)*random(1)*random(1);
      float des2 = int(random(10000));
      float det2 = random(1)*random(1)*random(1);
      float vel = random(-60, 60)*random(0.2, 1)*random(1)*random(1);
      float tt = time*vel;
      float amp = random(0.4, 0.6);
      int dir = int(random(2));
      float nt = random(0.1)*random(0.1)*random(1);
      noStroke();
      //stroke(255, 0, 0);
      fill(250);
      int cc = (dir == 0)? int(ww) : int(hh);
      int count = 0;
      for (int i = 0; i < cc; i++) {
        float d = i*100./cc;
        float noi = noise(tt+des1+(det1*d)*noise(des2+det2*d), time*nt);
        if (noi > amp) {
          count++;
        }
        if (count > 0 && (i == cc-1 || noi <= amp)) {
          if (dir == 0) rect(xx+i-count+1, yy, count, hh);
          if (dir == 1) rect(xx, yy+i-count+1, ww, count);
          count = 0;
        }
      }
    }
    if (rnd == 1) {
      int cc = int(random(2, random(8, min(ww, hh)/4)));

      int cw = max(2, int(ww/cc));
      int ch = max(2, int(hh/cc));

      float dw = ww/cw;
      float dh = hh/ch;
      float dir = random(TWO_PI);
      float vel = time*random(1, 8)*random(1); 
      if (abs(vel) < 1) vel = (vel >0)? 1 : -1;
      float dnx = cos(dir)*vel;
      float dny = sin(dir)*vel;
      float det = random(0.5)*random(1)*random(1);
      float mid = 0.5;//random(0.4, 0.6);
      float pwr = random(1, random(1, 10));
      float b = 1;
      float x = b+xx;
      float y = b+yy;
      float sw = dw-b*2;
      float sh = dh-b*2;
      noStroke(); 
      for (int j = 0; j < ch; j++) {
        for (int i = 0; i < cw; i++) {
          float noi = noise(i*det+dnx, j*det+dny);
          if (noi < mid) noi = map(pow(map(noi, 0, mid, 0, 1), pwr), 0, 1, 0, mid);
          else noi = map(pow(map(noi, mid, 1, 1, 0), pwr), 0, 1, 1, mid);
          fill(noi*255, 240);
          rect(x+i*dw, y+j*dh, sw, sh);
        }
      }
    }
    if (rnd == 2) {
      if (isRect) {
        float cx = xx+ww*0.5;
        float cy = yy+hh*0.5;
        float ss = ww*random(0.8, 0.9);
        int sub = int(random(3, min(30, ww*0.4)));
        int div = int(int(random(3, 12)))*4;
        stroke(255, 32);
        noFill();
        float da = TWO_PI/div;
        float r1 = ss*0.5;
        float r2 = r1/sub;
        for (int i = 0; i < div; i++) {
          float dx = cos(da*i);
          float dy = sin(da*i);
          line(cx+dx*r1, cy+dy*r1, cx+dx*r2, cy+dy*r2);
        }
        for (int i = 0; i < sub; i++) {
          float s = map(i, 0, sub, ss, 0);
          ellipse(cx, cy, s, s);
        }


        int cc = int(random(1, 5));
        noFill();
        float val[] = new float[div];
        float dx, dy, dd1, dd2, ang;
        for (int j = 0; j < cc; j++) {
          for (int i = 0; i < div; i++) {
            val[i] = map(pow(noise(i*random(1)+time*random(1)*random(1)), random(0.5, 1)), 0, 1, 1, sub);
          }
          stroke(random(120, 250));
          for (int i = 0; i < div; i++) {
            ang = da*i;
            dx = cos(ang);
            dy = sin(ang);
            dd1 = map(val[i], sub, 0, ss*0.5, 0);
            dd2 = map(val[(i+1)%div], sub, 0, ss*0.5, 0);
            arc(cx, cy, dd2*2, dd2*2, ang, ang+da);
            //line(cx+d1x*dd1, cy+d1y*dd1, cx+d2x*dd1, cy+d2y*dd1);
            line(cx+dx*dd1, cy+dy*dd1, cx+dx*dd2, cy+dy*dd2);
          }
        }
      } else {
        int cc = int(random(2, random(8, min(ww, hh)/4)));
        int cw = max(2, int(ww/cc));
        int ch = max(2, int(hh/cc));

        fill(20);
        rect(xx, yy, ww, hh);

        float dw = ww/cw;
        float dh = hh/ch;
        float mid = random(random(0.3, 0.5), random(0.5, 0.8));
        float b = min(dw, dh)*random(0.2, 0.4);//random(0.1, 0.8);
        float x = b+xx;
        float y = b+yy;
        float sw = dw-b*2;
        float sh = dh-b*2;
        noStroke(); 
        float tt = time*random(4)*random(1)*random(1);
        for (int j = 0; j < ch; j++) {
          for (int i = 0; i < cw; i++) {
            if (noise(random(100), tt) > mid) {
              fill(240);
            } else {
              fill(0);
            }
            rect(x+i*dw, y+j*dh, sw, sh);
          }
        }
      }
    }
    if (rnd == 3) {
      if (isRect) {
        float cx = xx+ww*0.5;
        float cy = yy+hh*0.5;
        float ss = ww*random(0.8, 0.9);
        int sub = int(random(3, min(30, ww*0.2)));
        int div = int(int(random(1, 8)))*4;
        stroke(255, 60);
        noFill();
        float da = TWO_PI/div;
        float r1 = ss*0.5;
        float r2 = r1/sub;
        float dx, dy;
        for (int i = 0; i < div; i++) {
          dx = cos(da*i);
          dy = sin(da*i);
          line(cx+dx*r1, cy+dy*r1, cx+dx*r2, cy+dy*r2);
        }
        for (int i = 0; i < sub; i++) {
          float s = map(i, 0, sub, ss, 0);
          ellipse(cx, cy, s, s);
        }

        stroke(255, 80);
        fill(255, 30);
        int cc = int(random(1, 5));
        int res = int(max(16, (r1*PI)*0.3));
        float des = random(1000);
        float da2 = TWO_PI/res;
        float rr, noi;
        float p1 = random(0.5, 1);
        float p2 = random(1, 4);
        float mr = random(random(0.5, 1), 1);
        float det = random(3)*random(0.4, 1);
        float tt = time*random(5)*random(1)*random(0.2, 1);
        float dd = random(10)*random(1);
        float dir = random(TWO_PI);
        float ddx = cos(dir)*tt;
        float ddy = sin(dir)*tt;
        for (int j = 0; j < cc; j++) {
          beginShape();
          float rrr = map(j, 0, cc, 1, mr);
          float pwr = map(j, 0, cc, p1, p2);
          for (int i = 0; i < res; i++) {
            noi = noise(ddx+des+cos(i*da2)*det, ddy+des+sin(i*da2)*det, j*dd);
            rr = map(pow(noi, pwr), 0, 1, r1, r2)*rrr;
            vertex(cx+cos(da2*i)*rr, cy+sin(da2*i)*rr);
          }
          endShape(CLOSE);
        }
      }
    }
    if (rnd == 4) {
      if (isRect) {
        float cx = xx+ww*0.5;
        float cy = yy+hh*0.5;
        float ss = ww*random(0.8, 0.9);
        int sub = int(random(3, min(30, ww*0.2)));
        int div = int(int(random(1, 8)))*4;
        stroke(255, 60);
        float da = TWO_PI/div;
        float r1 = ss*0.5;
        float r2 = r1/sub;
        for (int i = 0; i < div; i++) {
          float dx = cos(da*i);
          float dy = sin(da*i);
          line(cx+dx*r1, cy+dy*r1, cx+dx*r2, cy+dy*r2);
        }
        for (int i = 0; i < sub; i++) {
          float s = map(i, 0, sub, ss, 0);
          ellipse(cx, cy, s, s);
        }
      }
    }
  }
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}
int colors[] = {#2F2624, #207193, #EF4C31, #EE4E7C, #ffffff};
int rcol() {
  return colors[int(random(colors.length))];
}
int getColor(float v) {
  v = abs(v);
  v = v%(colors.length); 
  int c1 = colors[int(v%colors.length)]; 
  int c2 = colors[int((v+1)%colors.length)]; 
  return lerpColor(c1, c2, v%1);
}
void shuffleArray(int[] array) {
  for (int i = array.length; i > 1; i--) {
    int j = int(random(i));
    int tmp = array[j];
    array[j] = array[i-1];
    array[i-1] = tmp;
  }
}