void setup() {
  size(960, 960);
  generate();
}


void draw() {
}

void keyPressed() {
  if (key == 'e') erosion();
  else if (key == 's') saveImage();
  else if (key == 'i') filter(INVERT);
  else generate();
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

void generate() {
  float det1 = random(0.01);
  float des1 = random(100000);
  float val1 = random(0.7, 1);
  float pow1 = random(0.7, 1);
  float det2 = random(0.06);
  float des2 = random(100000);
  float val2 = random(-0.3, 0.3)*random(1);
  float pow2 = random(0.7, 1);
  float min = random(0.3);
  float max = random(0.8, 1);
  float lim = random(0.08)*random(1);
  for (int j = 0; j < height; j++) {
    for (int i = 0; i < width; i++) {
      float val = pow(noise(i*det1+des1, j*det1+des1)*val1, pow1);
      val += pow(noise(i*det2+des2, j*det2+des2)*abs(val2), pow2)*sign(val2);
      if (val < min) val = map(val, 0, min, 0, lim);
      else if (val > max) val = map(val, 0, min, 1-lim, 1);
      else val = map(val, min, max, lim, 1-lim);
      set(i, j, color(val*255));
    }
  }
}

void erosion() {
  for (int c = 0; c < 100000; c++) {
    int x = int(random(width));
    int y = int(random(height));

    boolean done = false;
    while (!done) {
      float val = red(get(x, y));
      float prom = 0;
      int count = 0;
      ArrayList<PVector> points = new ArrayList<PVector>();
      for (int dy = 0; dy < 3; dy++) {
        for (int dx = 0; dx < 3; dx++) {
          int xx = x+dx-1;
          int yy = y+dy-1;
          if (xx < 0 || xx >= width || yy < 0 || yy >= height) continue;
          float aux = red(get(xx, yy));
          if (aux < val) {
            prom += abs(aux-val);
            points.add(new PVector(xx, yy, aux));
          }
        }
      }

      if (points.size() > 0) {
        set(x, y, color(val-1));
        PVector n = points.get(0);
        float sum = 0;
        float rnd = random(prom);
        for (int i = 0; i < points.size(); i++) {
          n = points.get(i);
          sum += abs(n.z-val);
          if (sum > rnd) {
            break;
          }
        }
        x = int(n.x);
        y = int(n.y);
      } else {
        done = true;
      }
      count++;
      if (count > 100) done = true;
    }
  }
}

float sign(float v) {
  if (v < 0) return -1;
  if (v > 0) return 1;
  return 0;
}