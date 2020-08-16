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

  int sub = int(random(500)*random(1)*random(1));
  for (int i = 0; i < sub; i++) {
    int ind = int(random(rects.size()*random(1)));
    Rect r = rects.get(ind);
    float nw = r.w*0.5;
    float nh = r.h*0.5;
    rects.add(new Rect(r.x, r.y, nw, nh));
    rects.add(new Rect(r.x+nw, r.y, r.w-nw, nh));
    rects.add(new Rect(r.x+nw, r.y+nh, r.w-nw, r.h-nh));
    rects.add(new Rect(r.x, r.y+nh, nw, r.h-nh));
    rects.remove(ind);
  }

  //rects.add(0, new Rect(0, 0, width, height));
  noStroke();
  for (int c = 0; c < rects.size(); c++) {
    Rect r = rects.get(c);
    int back = rcol();
    int col = rcol();
    while (col == back) col = rcol();

    if (random(1) < 0.8) {
      fill(back);
      rect(r.x, r.y, r.w, r.h);
    }
    if (random(1) < 0.8) {
      fill(col);
      if (random(1) < 0.1) {
        cuarto(r.x, r.y, r.w, r.h, 0);
        cuarto(r.x, r.y, r.w, r.h, 1);
        cuarto(r.x, r.y, r.w, r.h, 2);
        cuarto(r.x, r.y, r.w, r.h, 3);
      } else {
        int mul = (random(1) < 0.5)? 1 : 2;
        cuarto(r.x, r.y, r.w, r.h, int(random(4)), mul);
      }
    }
  }
}
void cuarto(float x, float y, float w, float h, int dir) {
  cuarto(x, y, w, h, dir, 1);
};
void cuarto(float x, float y, float w, float h, int dir, int mul) {
  dir %= 4;
  if (dir == 0) arc(x, y, w*mul, h*mul, 0, HALF_PI);
  if (dir == 1) arc(x+w, y, w*mul, h*mul, HALF_PI, PI);
  if (dir == 2) arc(x+w, y+h, w*mul, h*mul, PI, PI*1.5);
  if (dir == 3) arc(x, y+h, w*mul, h*mul, PI*1.5, TWO_PI);
}

//https://coolors.co/280f04-e2dcd0-bf1a2b-417f5c-6898c1
//int colors[] = {#280f04, #e2dcd0, #bf1a2b, #417f5c, #6898c1};
int colors[] = {#f13434, #8e41bd, #ffe931, #fe96c7, #f7f6f6, #63d596, #ff7e38, #42b1ff};

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