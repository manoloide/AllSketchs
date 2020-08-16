int seed = int(random(999999));

void setup() {
  size(960, 960, P3D);
  smooth(8);
  pixelDensity(2);
  generate();

  //saveImage();
  //exit();
}

void draw() {
  //generate();
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
  background(0);

  ArrayList<Rect> rects = new ArrayList<Rect>();
  rects.add(new Rect(0, 0, width, height));

  int sub = int(random(30));
  for (int j = 0; j < sub; j++) {
    int ind = int(random(rects.size()));
    Rect r = rects.get(ind);

    if (random(1) < 0.5) {
      float mw = r.w*random(0.4, 0.6);
      rects.add(new Rect(r.x, r.y, mw, r.h));
      rects.add(new Rect(r.x+mw, r.y, r.w-mw, r.h));
    } else {
      float mh = r.h*random(0.4, 0.6);
      rects.add(new Rect(r.x, r.y, r.w, mh));
      rects.add(new Rect(r.x, r.y+mh, r.w, r.h-mh));
    }

    rects.remove(ind);
  }

  noStroke();
  for (int i = 0; i < rects.size(); i++) {
    if (random(1) < 0.4) continue;
    Rect r = rects.get(i);
    fill(rcol());
    rect(r.x, r.y, r.w, r.h);
    fill(rcol());
    float ss = min(r.w, r.h)*0.2;

    fill(rcol());
    if (random(1) < 0.5) {
      rect(r.x, r.y, ss, ss);
    }
    if (random(1) < 0.5) {
      rect(r.x+r.w-ss, r.y, ss, ss);
    }
    if (random(1) < 0.5) {
      rect(r.x+r.w-ss, r.y+r.h-ss, ss, ss);
    }
    if (random(1) < 0.5) {
      rect(r.x, r.y+r.h -ss, ss, ss);
    }

    fill(rcol());
    if (random(1) < 0.5) {
      triangle(r.x, r.y, r.x+ss, r.y, r.x, r.y+ss);
    }
    if (random(1) < 0.5) {
      triangle(r.x+r.w-ss, r.y, r.x+r.w, r.y+ss, r.x+r.w, r.y);
    }
    if (random(1) < 0.5) {
      triangle(r.x+r.w-ss, r.y+r.h, r.x+r.w, r.y+r.h-ss, r.x+r.w, r.y+r.h);
    }
    if (random(1) < 0.5) {
      triangle(r.x+ss, r.y+r.h, r.x, r.y+r.h-ss, r.x, r.y+r.h);
    }  
    fill(rcol());
    rect(r.x+(r.w-ss)*0.5, r.y+(r.h-ss)*0.5, ss, ss);
    fill(rcol());
    ellipse(r.x+r.w*0.5, r.y+r.h*0.5, ss*0.2, ss*0.2);
  }
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

int colors[] = {#FF4B00, #FFC500, #00DEB5, #3030D0, #FF97D6, #FFFFFF, #000000};
//int colors[] = {#FFFFFF, #000000};
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