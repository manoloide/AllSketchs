void setup() {
  size(1920, 960);
  generate();
}

void draw() {
}

void keyPressed() {
  if (key == 's') saveImage();
  else generate();
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

void generate() {
  background(40);

  noStroke();
  float step = 10;
  /*
  for (int i = 0; i < 100000; i++) {
   float x = int(random(width+step));
   float y = int(random(height+step));
   float s = step*random(1);
   x -= x%step;
   y -= y%step;
   fill(random(256));
   ellipse(x, y, s, s);
   }
   */

  stroke(0, 20);
  grid(0, 0, width, height, step);
  grid(0, 0, width, height, step*2);
  grid(0, 0, width, height, step*4);

  noStroke();
  fill(255, 50);
  gridRect(0, 0, width, height, step*int(pow(2, int(random(0, 4)))), random(0.05, 0.1));



  noStroke();
  for (int i = 0; i < 40; i++) {
    float x = int(random(width+step));
    float y = int(random(height+step));
    float s = step*floor(random(1, 4));
    float w = int(random(4, (width/s)*random(0.5, 1)));
    float h = int(random(4, (height/s)*random(0.5, 1)));
    x -= floor(w/2)*s;
    y -= floor(h/2)*s;
    x -= x%s;
    y -= y%s;
    gridNoise(x, y, w*s, h*s, s);
  }


  ArrayList<Rect> rects = new ArrayList<Rect>();
  rects.add(new Rect(0, 0, width/2, height));
  rects.add(new Rect(width/2, 0, width/2, height));

  for (int i = 0; i < 100; i++) {
    int ind = int(random(rects.size()));
    Rect r = rects.get(ind);

    float rnd = random(1);
    if (r.w <= step || r.h <= step) continue;
    if (r.w <=step) rnd = 1;
    if (r.h <=step) rnd = 0; 
    if (rnd < 0.5) {
      rects.add(new Rect(r.x, r.y, r.w/2, r.h));
      rects.add(new Rect(r.x+r.w/2, r.y, r.w/2, r.h));
    } else {
      rects.add(new Rect(r.x, r.y, r.w, r.h/2));
      rects.add(new Rect(r.x, r.y+r.h/2, r.w, r.h/2));
    }

    rects.remove(ind--);
  }

  for (int i = 0; i < rects.size(); i++) {
    Rect r = rects.get(i);
    float s = step*pow(2, floor(random(0, 4)));
    stroke(255, random(40, 120));
    gridDiag(r.x, r.y, r.w, r.h, s, int(random(2)));
  }  

  /*
    for (int i = 0; i < 40; i++) {
   float x = int(random(width+step));
   float y = int(random(height+step));
   float s = step*pow(2, floor(random(0, 4)));
   float w = int(random(2, (width/s)*random(0.2, 1)));
   float h = int(random(2, (height/s)*random(0.2, 1)));
   x -= floor(w/2)*s;
   y -= floor(h/2)*s;
   x -= x%(s*2);
   y -= y%(s*2);
   stroke(255, random(40, 120));
   gridDiag(x, y, h*s, h*s, s, int(random(2)));
   }
   */


  /*
  stroke(0, 20);
   for (int i = 0; i < 1000; i++) {
   float x = int(random(width+step));
   float y = int(random(height+step));
   float s = step*random(0.5);
   x -= x%step+s*0.5;
   y -= y%step+s*0.5;
   fill(rcol());
   rect(x, y, s, s);
   }
   */

  //blendMode(ADD);
  /*
  noStroke();
   for (int i = 0; i < 10; i++) {
   float x = int(random(width+step));
   float y = int(random(height+step));
   float s = step*pow(2, floor(random(0, 5)));
   float w = int(random(2, (width/s)*random(0.2, 0.5)));
   float h = int(random(2, (height/s)*random(0.2, 0.5)));
   x -= floor(w/2)*s;
   y -= floor(h/2)*s;
   x -= x%s;
   y -= y%s;
   fill(rcol(), random(220, 240));
   gridCircle(x, y, w*s, h*s, step*int(pow(2, int(random(0, 4)))), random(0.1, 0.8)*random(0.4, 1));
   }
   blendMode(BLEND);
   */


  /*
  for (int i = 0; i < 1000; i++) {
   int x = int(random(width)); 
   int y = int(random(height)); 
   int w = int(random(200)); 
   int h = int(random(200));
   x -= w/2;
   y -= h/2;
   noisee(int(random(5)), x, y, w, h);
   }
   */

  /*
  noStroke();
   fill(#E5BF25, 60);
   blendMode(ADD);
   float des = random(1)*random(1);
   for (float j = step/2; j < height+step; j+=step) {
   for (float i = step/2; i < width+step; i+=step) {
   float s = step*random(1);
   s = step*cos(dist(i, j, width/2, height/2)*des);
   fill(#E5BF25, 200);
   ellipse(i, j, s, s);
   s *= random(1);
   fill(#E5BF25, 40);
   ellipse(i, j, s, s);
   s *= random(1);
   ellipse(i, j, s, s);
   }
   }
   
   blendMode(BLEND);
   */


  noisee(int(random(5)), 0, 0, width, height);
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

int cols[] = {#5725E5, #FACA2B};

int rcol() {
  //return lerpColor(cols[0], cols[1], random(1));
  return cols[int(random(cols.length))];
}


void grid(float x, float y, float w, float h, float stp) {
  w -= w%stp;
  h -= h%stp;
  for (float i = x; i <= x+w; i+=stp) {
    line(i, y, i, y+h);
  }
  for (float j = y; j <= y+h; j+=stp) {
    line(x, j, x+w, j);
  }
}

void gridCircle(float x, float y, float w, float h, float stp, float s) {
  w -= w%stp;
  h -= h%stp;
  float ss = stp*s;
  x -= stp*0.5;
  y -= stp*0.5;
  for (float j = y; j <= y+h+1; j+=stp) {
    for (float i = x; i <= x+w+1; i+=stp) {
      ellipse(i, j, ss, ss);
    }
  }
}

void gridRect(float x, float y, float w, float h, float stp, float s) {
  w -= w%stp;
  h -= h%stp;
  float ss = stp*s;
  x -= (stp+ss)*0.5;
  y -= (stp+ss)*0.5;
  for (float j = y; j <= y+h+1; j+=stp) {
    for (float i = x; i <= x+w+1; i+=stp) {
      rect(i, j, ss, ss);
    }
  }
}

void gridNoise(float x, float y, float w, float h, float stp) {
  w -= w%stp;
  h -= h%stp;

  for (float j = y; j <= y+h; j+=stp) {
    for (float i = x; i <= x+w; i+=stp) {
      fill(random(256), 5);
      rect(i, j, stp, stp);
    }
  }
}

void gridDiag(float x, float y, float w, float h, float stp, int dir) {
  w -= w%stp;
  h -= h%stp;
  float xx = x;
  float mx = x+w;
  if (dir == 0) xx-=h;
  else mx +=h;
  for (float i = xx; i <= mx; i+=stp) {
    float x1 = i;
    float y1 = y;
    float x2 = i+ ((dir== 0)? h : -h);
    float y2 = y+h;
    if (dir == 1) {
      if (x1 > x+w) {
        float des = x1-(x+w);
        x1 -= des;
        y1 += des;
      }
      if (x2 < x) {
        float des = x2-x;
        x2 -= des;
        y2 += des;
      }
    } else {
      if (x2 > x+w) {
        float des = x2-(x+w);
        x2 -= des;
        y2 -= des;
      }
      if (x1 < x) {
        float des = x1-x;
        x1 -= des;
        y1 -= des;
      }
    }
    line(x1, y1, x2, y2);
  }
}

void noisee(int n, int x, int y, int w, int h) {
  int x1 = constrain(x, 0, width);
  int x2 = constrain(x+w, 0, width);
  int y1 = constrain(y, 0, height);
  int y2 = constrain(y+h, 0, height);
  for (int j = y1; j < y2; j++) {  
    for (int i = x1; i < x2; i++) {
      color col = get(i, j);
      float b = random(-n, n);
      col = color(red(col)+b, green(col)+b, blue(col)+b);
      set(i, j, col);
    }
  }
}