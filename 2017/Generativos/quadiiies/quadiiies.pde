void setup() {
  size(960, 960);
  pixelDensity(2);
  generate();
}

void draw() {
  //if (frameCount%40 == 0) generate();
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
  background(240);
  noisee(5);

  int bb = 0;//int(random(5, 30));
  float sub = int(random(3, 50));
  float ss = (width-bb*2.0)/sub;
  noFill();
  strokeWeight(2);
  stroke(255, 10);
  rect(bb, bb, width-bb*2, height-bb*2);
  strokeWeight(1);
  for (int j = 0; j < sub; j++) {
    for (int i = 0; i < sub; i++) {
      rect(bb+i*ss, bb+j*ss, ss, ss);
    }
  }

  ArrayList<Rect> rects = new ArrayList<Rect>();
  fill(255, 20);
  for (int c = 0; c < 10000000; c++) {
    int x = int(random(sub));
    int y = int(random(sub));
    int w = int(random(1, sub-x));
    int h = int(random(1, sub-y));

    Rect aux = new Rect(x, y, w, h);
    boolean add = true;
    for (int j = 0; j < rects.size(); j++) {
      Rect ant = rects.get(j);
      if (aux.col(ant)) {
        add = false;
        break;
      }
    }

    if (add) {
      rects.add(aux);
      fill(random(256), 40);
      rect(bb+ss*x, bb+ss*y, w*ss, h*ss);

      int subb = int(random(3, 10));
      float sss = ss/subb;

      for (int j = 0; j < h*subb; j++) {
        for (int i = 0; i < w*subb; i++) {
          fill(random(256), random(10, 50));
          fill(getColor(random(4)));
          rect(bb+ss*x+i*sss, bb+ss*y+j*sss, sss, sss);
        }
      }
    }
  }

  noisee(2);
  noisee(5);
}

class Rect {
  int x, y, w, h;
  Rect(int x, int y, int w, int h) {
    this.x = x; 
    this.y = y; 
    this.w = w; 
    this.h = h;
  }

  boolean col(Rect other) {
    return (x < other.x + other.w &&x + w > other.x && y < other.y + other.h && h + y > other.y);
  }
}

void noisee(float v) {
  for (int j = 0; j < height; j++) {
    for (int i = 0; i < width; i++) {
      float bri = random(-v, v);
      color col = get(i, j);
      col = color(red(col)+bri, green(col)+bri, blue(col)+bri);
      set(i, j, col);
    }
  }
}  

int colors[] = {#FF5200, #003355, #04536C, #ADACA7};

int getColor(float v) {
  v = v%(colors.length);

  int c1 = colors[int(v%colors.length)];
  int c2 = colors[int((v+1)%colors.length)];
  float m = v%1;

  return lerpColor(c1, c2, m);
}