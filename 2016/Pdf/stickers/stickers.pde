import processing.pdf.*;
void settings() {
  float widthCm = 7;
  float heightCm = 7;
  float dpi = 300;
  int w = int((widthCm*dpi)/2.54);
  int h = int((heightCm*dpi)/2.54);
  size(w, h, PDF, getTimestamp()+".pdf");
}

void setup() {
}

void draw() {

  background(40);

  int sep = 50;
  int ss = 40;
  int dx = 25;
  int dy = 25;

  noStroke();
  for (int j = dx; j < height; j+=sep) {
    for (int i = dy; i < width; i+=sep) {
      color c1 = rcol();
      color c2 = rcol();
      while (c1 == c2) c2 = rcol();

      /*
      fill(c1);
       ellipse(i, j, ss, ss);
       fill(c2);
       float s2 = ss*random(0.2, 1);
       ellipse(i, j, s2, s2);
       */

      /*
      int cc = int(random(2, random(3, 10)));
       float des = 1./cc;
       for (int k = 1; k <= cc; k++) {
       fill(lerpColor(c1, c2, map(k, 1, cc, 0, 1)));
       float s2 = map(k, 1, cc+1, ss, 0);
       ellipse(i, j, s2, s2);
       }
       */
    }
  }

  //tramaLinitas(1000, 2);
  tramaCurvitas(int(random(200, 2200)), random(10, 40), int(random(4, 14)), random(0.05, 0.4));

  println("Finished.");
  exit();
}


void tramaLinitas(int cc, float len) {
  noFill();
  for (int i = 0; i < cc; i++) {
    float x = random(width);
    float y = random(height);
    float angle = random(TWO_PI);

    strokeWeight(random(1, 4));
    stroke(rcol());

    beginShape();
    vertex(x-cos(angle)*len, y-sin(angle)*len);
    vertex(x+cos(angle)*len, y+sin(angle)*len);
    endShape();
  }
}

void tramaZigzag(int c, float len, int cc, float amp) {
  noFill();
  for (int i = 0; i < c; i++) {
    float x = random(width);
    float y = random(height);

    float angle = random(TWO_PI);

    float r = len*0.5;
    float x1 = x-cos(angle)*r;
    float y1 = y-sin(angle)*r;
    float x2 = x+cos(angle)*r;
    float y2 = y+sin(angle)*r;

    float des = len/(cc);

    float dx = cos(angle+PI/2)*len*amp;
    float dy = sin(angle+PI/2)*len*amp;

    stroke(rcol());
    strokeWeight(random(1, len*amp*0.5));
    beginShape();
    vertex(x1, y1);
    for (int k = 0; k < cc; k++) {
      float xx = x1+cos(angle)*(des*(k+0.5));
      float yy = y1+sin(angle)*(des*(k+0.5));
      float ll = (k%2 == 0)? -1 : 1;
      vertex(xx+dx*ll, yy+dy*ll);
    }
    vertex(x2, y2);
    endShape();
  }
}

void tramaCurvitas(int c, float len, int cc, float amp) {
  noFill();
  for (int i = 0; i < c; i++) {
    float x = random(width);
    float y = random(height);

    float angle = random(TWO_PI);

    float r = len*0.5;
    float x1 = x-cos(angle)*r;
    float y1 = y-sin(angle)*r;
    float x2 = x+cos(angle)*r;
    float y2 = y+sin(angle)*r;

    float des = len/(cc);

    float dx = cos(angle+PI/2)*len*amp;
    float dy = sin(angle+PI/2)*len*amp;

    stroke(rcol());
    strokeWeight(random(1, len*amp*0.5));
    beginShape();
    curveVertex(x1, y1);
    for (int k = 0; k < cc; k++) {
      float xx = x1+cos(angle)*(des*(k+0.5));
      float yy = y1+sin(angle)*(des*(k+0.5));
      float ll = (k%2 == 0)? -1 : 1;
      curveVertex(xx+dx*ll, yy+dy*ll);
    }
    curveVertex(x2, y2);
    endShape();
  }
}

int colors[] = {
  #146dad, 
  #ea5c0a, 
  #ffffff, 
  #000000
};

int rcol() {
  return colors[int(random(colors.length-0.9))];
}

String getTimestamp() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  return timestamp;
}