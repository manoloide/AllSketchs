int seed = int(random(999999));

void setup() {
  size(960, 960);
  smooth(8);
  pixelDensity(2);
  generate();
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
  background(255);

  ArrayList<Rect> rects = new ArrayList<Rect>();
  float bb = 16;
  rects.add(new Rect(bb, bb, width-bb*2, height-bb*2));
  int cc = int(random(1000)*random(1)*random(1));
  for (int i = 0; i < cc; i++) {
    int ind = int(random(rects.size()));
    Rect r = rects.get(ind);
    int sub = int(random(2, 5));
    boolean hor = random(1) < 0.5;
    float ss = r.h/sub;
    if (hor) ss = r.w/sub;
    if (ss > 5) {
      for (int j = 0; j < sub; j++) {
        float xx = r.x;
        float yy = r.y;
        float ww = r.w;
        float hh = r.h;
        if (hor) {
          xx += ss*j;
          ww = ss;
        } else {
          yy += ss*j;
          hh = ss;
        }
        rects.add(new Rect(xx, yy, ww, hh));
      }
      rects.remove(ind);
    }
  }

  for (int c = 0; c < rects.size(); c++) {
    Rect r = rects.get(c);
    int w = ceil(r.w);
    int h = ceil(r.h);
    PGraphics gra = createGraphics(w, h);
    int rnd = int(random(2));
    rnd = 1; 
    gra.beginDraw();
    gra.background(255);
    if (rnd == 1) {
      float des = random(1000);
      float det1 = random(0.02)*random(1);
      float det2 = random(0.02)*random(1);
      //float det3 = random(0.01)*random(1);
      gra.stroke(0, 70);
      float d = random(14, 20);
      int ccc = int(w*h*random(0.7, 1.2));
      for (int i = 0; i < ccc; i++) {
        float xx = random(-d, w+d);
        float yy = random(-d, h+d);
        float ang = noise(des+xx*det1, des+yy*det1)*TWO_PI;
        float dis = noise(des+xx*det2, des+yy*det2)*d;

        //gra.stroke(getColor(noise(des+xx*det3, des+yy*det3)*colors.length), 40);
        gra.line(xx, yy, xx+cos(ang)*dis, yy+sin(ang)*dis);
      }
    }
    gra.endDraw();
    image(gra, r.x, r.y);
  }
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

//https://coolors.co/f2f2e8-ffe41c-ef3434-ed0076-3f9afc
int colors[] = {#155263, #FF6F3C, #FF9A3C, #FFC93C};

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