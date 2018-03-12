int seed = int(random(999999));

void setup() {
  size(960, 960, P2D);
  smooth(8);
  pixelDensity(2);
  generate();
}

void draw() {
}

void keyPressed() {
  if (key == 's') saveImage();
  else generate();
}

void generate() {
  background(0);

  noFill();
  stroke(255);

  int div = int(random(4, random(4, 64)));
  float sh = width*1./(div-1);

  float y1[] = new float[div+1];
  float y2[] = new float[div+1];
  for (int j = 0; j <= div; j++) {
    y1[j] = sh*j;
    y2[j] = sh*j;
  }

  y1 = defs(y1, 0, height, 4, random(1, 6));
  y2 = defs(y2, 0, height, 4, random(1, 6));

  noStroke();
  for (int j = 0; j < div; j++) {
    int sub = int(random(4, random(4, 256)));
    float ic = random(100);
    float dc = random(colors.length)*random(1)*random(1);

    float sw = width*1./(sub-1);
    float x1[] = new float[sub+1];
    float x2[] = new float[sub+1];
    for (int k = 0; k <= sub; k++) {
      x1[k] = sw*k;
      x2[k] = sw*k;
    }

    x1 = defs(x1, 0, width, 2, 2);
    x2 = defs(x2, 0, width, 2, 2);

    for (int i = 0; i < sub; i++) {
      float xx1 = x1[i];
      float xx2 = x1[i+1];
      float xx3 = x2[i+1];
      float xx4 = x2[i];
      float yy1 = map(xx1, 0, width, y1[j], y2[j]);
      float yy2 = map(xx2, 0, width, y1[j], y2[j]);
      float yy3 = map(xx3, 0, width, y1[j+1], y2[j+1]);
      float yy4 = map(xx4, 0, width, y1[j+1], y2[j+1]);
      //stroke(255);

      fill(getColor(ic+dc*i));
      beginShape();
      vertex(xx1, yy1);
      vertex(xx2, yy2);
      vertex(xx3, yy3);
      vertex(xx4, yy4); 
      endShape(CLOSE);
    }
  }


  // rectMode(CENTER);
  /*
  noStroke();
   for (int j = 0; j <= div; j++) {
   int sub = int(random(4, 32));
   float sw = width*1./sub;
   sw += 1;
   for (int i = 0; i <= sub; i++) {
   fill(getColor(random(colors.length)));
   rect(i*(sw-1), j*sh, sw, sh);
   }
   }
   */
}

float[] defs(float values[], float min, float max, int cc, float maxpwr) {
  for (int j = 0; j < cc; j++) {
    float cy = random(0.01, 0.99);
    float d1 = cy;
    float pwr = random(1./maxpwr, 1);
    if (random(1) < 0.5) pwr = map(pwr, 1./maxpwr, 1, maxpwr, 1);
    for (int i = 0; i < values.length; i++) {
      float v = constrain(map(values[i], min, max, 0, 1), 0, 1);
      if (v < cy) {
        v = map(v, 0, d1, 0, 1);
        v = pow(v, pwr);
        v = map(v, 0, 1, 0, d1);
      } else {
        v = map(v, 1, d1, 0, 1);
        v = pow(v, pwr);
        v = map(v, 0, 1, 1, d1);
      }
      values[i] = map(v, 0, 1, min, max);
    }
  } 
  return values;
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

//https://coolors.co/fca50f-fc35d4-3a6ff4-2bbc93-7e1f86
int colors[] = {#fca50f, #fc35d4, #3a6ff4, #2bbc93};

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