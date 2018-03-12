int seed = int(random(999999));

void setup() {
  size(960, 960, P2D);
  smooth(8);
  pixelDensity(1);
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
  background(255);

  FloatList x1 = new FloatList();
  FloatList x2 = new FloatList(); 
  int cc = int(random(3, 6));//20)); 
  for (int i = 0; i < cc; i++) {
    x1.append(random(width));
    x2.append(random(width));
  }
  x1.sort();
  x2.sort();
  x1.append(x1.get(x1.size()-1)-width);
  x2.append(x2.get(x2.size()-1)-width);
  x1.append(width+x1.get(0));
  x2.append(width+x2.get(0));
  x1.sort();
  x2.sort();

  FloatList y1 = new FloatList();
  FloatList y2 = new FloatList(); 
  for (int i = 0; i < cc; i++) {
    y1.append(random(height));
    y2.append(random(height));
  }
  y1.sort();
  y2.sort();
  y1.append(y1.get(y1.size()-1)-height);
  y2.append(y2.get(y2.size()-1)-height);
  y1.append(height+y1.get(0));
  y2.append(height+y2.get(0));
  y1.sort();
  y2.sort();

  stroke(0, 100);
  for (int i = 0; i <= cc+1; i++) {
    line(0, y1.get(i), width, y2.get(i));
    if (i < cc+1) {
      float my1 = (y1.get(i)+y1.get(i+1))*0.5;
      float my2 = (y2.get(i)+y2.get(i+1))*0.5;
      lineSeg(0, my1, width, my2, 10, 0.6);
    }
  }
  for (int i = 0; i <= cc+1; i++) {
    line(x1.get(i), 0, x2.get(i), height);
    if (i < cc+1) {
      float mx1 = (x1.get(i)+x1.get(i+1))*0.5;
      float mx2 = (x2.get(i)+x2.get(i+1))*0.5;
      lineSeg(mx1, 0, mx2, height, 10, 0.6);
    }
  }

  PGraphics tex1 = createGraphics(width, height);
  tex1.beginDraw();
  tex1.background(0);
  tex1.noStroke();
  for (int i = 0; i <= cc; i++) {
    float mx1 = (x1.get(i+1)+x1.get(i))*0.5;
    float mx2 = (x2.get(i+1)+x2.get(i))*0.5;
    float s1 = 2*distPointLine(new PVector(x1.get(i), 0), new PVector(x2.get(i), height), new PVector(mx1, 0));
    float s2 = 2*distPointLine(new PVector(x1.get(i), 0), new PVector(x2.get(i), height), new PVector(mx2, height));
    boolean change = (i%2 == 0);
    float des = 5;//max(3, s1*random(0.01, 0.2));
    float xx, yy, ss;
    boolean inv = random(1) < 0.5;
    for (float j = -max(s1, s2); j <= height+max(s1, s2); j+=des) {
      change = !change;
      if (change) tex1.fill(0);
      else tex1.fill(255);
      tex1.fill(rcol());//getColor(random(colors.length)));
      if (inv) {
        xx = map(j, 0, height, mx2, mx1);
        yy = height-j;
        ss = map(j, 0, height, s2, s1);
      } else {
        xx = map(j, 0, height, mx1, mx2);
        yy = j;
        ss = map(j, 0, height, s1, s2);
      }
      tex1.ellipse(xx, yy, ss, ss);
    }
  }
  tex1.endDraw();

  PGraphics tex2 = createGraphics(width, height);
  tex2.beginDraw();
  tex2.background(0);
  tex2.noStroke();
  for (int i = 0; i <= cc; i++) {
    float my1 = (y1.get(i+1)+y1.get(i))*0.5;
    float my2 = (y2.get(i+1)+y2.get(i))*0.5;
    float s1 = 2*distPointLine(new PVector(0, y1.get(i)), new PVector(width, y2.get(i)), new PVector(0, my1));
    float s2 = 2*distPointLine(new PVector(0, y1.get(i)), new PVector(width, y2.get(i)), new PVector(width, my2));
    boolean change = (i%2 == 0);
    float des = 5;//max(3, s1*random(0.01, 0.2));
    float xx, yy, ss;
    boolean inv = random(1) < 0.5;
    for (float j = -max(s1, s2); j <= width+max(s1, s2); j+=des) {
      change = !change;
      if (change) tex2.fill(0);
      else tex2.fill(255);
      tex2.fill(rcol());//getColor(random(colors.length)));
      if (inv) {
        yy = map(j, 0, width, my2, my1);
        xx = width-j;
        ss = map(j, 0, width, s2, s1);
      } else {
        yy = map(j, 0, width, my1, my2);
        xx = j;
        ss = map(j, 0, width, s1, s2);
      }
      tex2.ellipse(xx, yy, ss, ss);
    }
  }
  tex2.endDraw();

  PGraphics mask = createGraphics(width, height);
  mask.beginDraw();
  mask.background(0);
  mask.noStroke();
  mask.fill(255);
  for (int j = 0; j < y1.size()-1; j++) {
    for (int i = 0; i < x1.size()-1; i++) {
      if ((i+j)%2 == 0) continue;
      PVector p1 = segmetnsIntersection(x1.get(i), 0, x2.get(i), height, 0, y1.get(j), width, y2.get(j));
      PVector p2 = segmetnsIntersection(x1.get(i+1), 0, x2.get(i+1), height, 0, y1.get(j), width, y2.get(j));
      PVector p3 = segmetnsIntersection(x1.get(i+1), 0, x2.get(i+1), height, 0, y1.get(j+1), width, y2.get(j+1));
      PVector p4 = segmetnsIntersection(x1.get(i), 0, x2.get(i), height, 0, y1.get(j+1), width, y2.get(j+1));
      if (p1 != null && p2 != null && p3 != null && p4 != null) { 
        mask.beginShape(); 
        mask.vertex(p1.x, p1.y);
        mask.vertex(p2.x, p2.y);
        mask.vertex(p3.x, p3.y);
        mask.vertex(p4.x, p4.y);
        mask.endShape();
      }
    }
  }
  mask.endDraw();


  //image(tex1, 0, 0);
  /*
   image(tex2, 0, 0);
   image(mask, 0, 0);
   */

  if (random(1) < 0.5) {
    image(tex1, 0, 0);
  } else {

    image(tex2, 0, 0);
  }

  /*
  for (int j = 0; j < pixelHeight; j++) {
   for (int i = 0; i < pixelWidth; i++) {
   float v = brightness(mask.get(i, j))/255;
   set(i, j, lerpColor(tex1.get(i, j), tex2.get(i, j), v));
   }
   }
   */

  /*
  stroke(0, 20);
   for (int i = 0; i <= cc+1; i++) {
   line(0, y1.get(i), width, y2.get(i));
   line(x1.get(i), 0, x2.get(i), height);
   if (i < cc+1) {
   float my1 = (y1.get(i)+y1.get(i+1))*0.5;
   float my2 = (y2.get(i)+y2.get(i+1))*0.5;
   lineSeg(0, my1, width, my2, 10, 0.6);
   float mx1 = (x1.get(i)+x1.get(i+1))*0.5;
   float mx2 = (x2.get(i)+x2.get(i+1))*0.5;
   lineSeg(mx1, 0, mx2, height, 10, 0.6);
   }
   }
   */
}

float distPointLine(PVector a, PVector b, PVector c) {
  PVector ab = new PVector(b.x-a.x, b.y-a.y);
  PVector ac = new PVector(c.x-a.x, c.y-a.y);
  float cross = ab.x * ac.y - ab.y * ac.x;
  float dist = cross / a.dist(b);
  return abs(dist);
}

void lineSeg(float x1, float y1, float x2, float y2, float seg, float amp) {
  float dd = dist(x1, y1, x2, y2);
  float ang = atan2(y2-y1, x2-x1);
  for (float d = 0; d < dd; d+=seg) {
    float xx1 = x1+cos(ang)*d;
    float yy1 = y1+sin(ang)*d;
    float xx2 = x1+cos(ang)*(d+seg*amp);
    float yy2 = y1+sin(ang)*(d+seg*amp);
    line(xx1, yy1, xx2, yy2);
  }
}

PVector segmetnsIntersection(float x1, float y1, float x2, float y2, float x3, float y3, float x4, float y4) {
  float A1 = y2-y1;
  float B1 = x1-x2;
  float C1 = A1*x1+B1*y1;

  float A2 = y4-y3;
  float B2 = x3-x4;
  float C2 = A2*x3+B2*y3;

  float delta = A1*B2 - A2*B1;
  if (delta == 0)
    return null;

  float nx = (B2*C1 - B1*C2)/delta;
  float ny = (A1*C2 - A2*C1)/delta;
  return new PVector(nx, ny);

  //if (abs(dist(nx, ny, x1, y1)+dist(nx, ny, x2, y2)-dist(x1, y1, x2, y2)) < 0.000001 && abs(dist(nx, ny, x3, y3)+dist(nx, ny, x4, y4)-dist(x3, y3, x4, y4)) < 0.000001) {
  //if (((abs(x1-nx)+abs(nx-x2))-abs(x1-x2) < 0.001) && ((abs(y1-ny)+abs(ny-y2))-abs(y1-y2) < 0.001)) {
  //if (pointInRect(nx, ny, min(x1, x2), min(y1, y2), abs(x1-x2), abs(y1-y2)) && pointInRect(nx, ny, min(x3, x4), min(y3, y4), abs(x3-x4), abs(y3-y4))) {
  //return new PVector(nx, ny);
  //}
  //return null;
}

int colors[] = {#EFF2EF, #9BCDD5, #65C0CB, #308AA5, #308AA5, #85A33C, #F4E300, #E8DBD1, #CE5367, #202219};
int rcol() {
  return colors[int(random(colors.length))] ;
}
int getColor(float v) {
  v = v%(colors.length);
  int c1 = colors[int(v%colors.length)];
  int c2 = colors[int((v+1)%colors.length)];
  return lerpColor(c1, c2, v%1);
}