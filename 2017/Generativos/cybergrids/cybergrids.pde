int seed = int(random(9999999));

void setup() {
  size(960, 960, P2D);
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
  background(rcol());

  ArrayList<Rect> rects = new ArrayList<Rect>();
  rects.add(new Rect(0, 0, width, height));

  int sub = int(random(200)*random(1));
  for (int i = 0; i < sub; i++) {
    int ind = int(random(rects.size()*random(1)));
    Rect r = rects.get(ind);
    float nw = r.w*random(0.1, 0.9);
    float nh = r.h*random(0.1, 0.9);
    rects.add(new Rect(r.x, r.y, nw, nh));
    rects.add(new Rect(r.x+nw, r.y, r.w-nw, nh));
    rects.add(new Rect(r.x+nw, r.y+nh, r.w-nw, r.h-nh));
    rects.add(new Rect(r.x, r.y+nh, nw, r.h-nh));
    rects.remove(ind);
  }

  //rects.add(0, new Rect(0, 0, width, height));
  for (int c = 0; c < rects.size(); c++) {
    Rect r = rects.get(c);
    int cw = int(max(2, random(r.w*random(0.1, 0.4))));
    int ch = int(max(2, random(r.h*random(0.1, 0.4))));
    float sw = r.w/cw;
    float sh = r.h/ch;
    float ic = random(colors.length);
    float ang = random(TWO_PI);
    float des = random(colors.length*random(1)*random(8))*random(0.1, 1);
    float dcw = cos(ang)*des;
    float dch = sin(ang)*des;
    for (int j = 0; j < ch; j++) {
      for (int i = 0; i < cw; i++) {
        fill(getColor(ic+dcw*i+dch*j));
        rect(r.x+sw*i, r.y+sh*j, sw, sh);
      }
    }
  }
}

//https://coolors.co/280f04-e2dcd0-bf1a2b-417f5c-6898c1
//int colors[] = {#280f04, #e2dcd0, #bf1a2b, #417f5c, #6898c1};
int colors[] = {#000000, #FFFFFF, #FF7700, #000000, #15FF4A, #000000, #000000, #BBBBFF};

int rcol() {
  return colors[int(random(colors.length))];
};
int getColor(float v) {
  v = (v%(colors.length)+colors.length)%colors.length;
  int c1 = colors[int(v%colors.length)];
  int c2 = colors[int((v+1)%colors.length)];
  float m = v%1;
  return lerpColor(c1, c2, m);
}