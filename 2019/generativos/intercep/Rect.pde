class Rect {
  float x, y, w, h;
  float str;
  int col, shw1, shw2;
  Rect() {
    x = random(width);
    y = random(height);

    x -= x%40;
    y -= y%40;

    w = h = 80+int(random(4)*random(random(40, 200)));

    str = random(random(2, 7), min(w, h)*random(0.1, 0.2));
    col = rcol();

    shw1 = lerpColor(col, color(0), 0.1);
    shw2 = lerpColor(col, color(0), 0.2);
  }

  void show() {

    blendMode(ADD);
    noStroke();
    beginShape();
    fill(col, random(random(10), 30));
    vertex(x-w*0.5, y-h*0.5);
    vertex(x+w*0.5, y-h*0.5);
    fill(col, random(20)*random(1));
    vertex(x+w*0.5, y+h*0.5);
    vertex(x-w*0.5, y+h*0.5);
    endShape();

    noStroke();
    beginShape();
    fill(col, random(10)*random(1));
    vertex(x-w*0.5, y-h*0.5);
    vertex(x+w*0.5, y-h*0.5);
    fill(col, random(20));
    vertex(x+w*0.5, y+h*0.5);
    vertex(x-w*0.5, y+h*0.5);
    endShape();
    blendMode(NORMAL);

    strokeWeight(str);
    stroke(col);
    noFill();
    rect(x, y, w, h);
    noStroke();
    fill(255, 20);
    rect(x, y, 20, 20);
    fill(255);
    rect(x, y, 5, 5);


    noStroke();
    float bb = str*0.25;

    beginShape();
    fill(shw1);
    vertex(x-w*0.5-str*0.5, y+h*0.5+str*0.5);
    vertex(x-w*0.5-str*0.5, y-h*0.5-str*0.5);
    fill(shw2);
    vertex(x-w*0.5-str*0.5-bb, y-h*0.5-str*0.5+bb);
    vertex(x-w*0.5-str*0.5-bb, y+h*0.5+str*0.5+bb);
    endShape();

    beginShape();
    fill(shw1);
    vertex(x-w*0.5-str*0.5, y+h*0.5+str*0.5);
    vertex(x+w*0.5+str*0.5, y+h*0.5+str*0.5);
    fill(shw2);
    vertex(x+w*0.5+str*0.5-bb, y+h*0.5+str*0.5+bb);
    vertex(x-w*0.5-str*0.5-bb, y+h*0.5+str*0.5+bb);
    endShape();

    beginShape();
    fill(shw1);
    vertex(x+w*0.5-str*0.5, y+h*0.5-str*0.5);
    vertex(x+w*0.5-str*0.5, y-h*0.5+str*0.5);
    fill(shw2);
    vertex(x+w*0.5-str*0.5-bb, y-h*0.5+str*0.5+bb);
    vertex(x+w*0.5-str*0.5-bb, y+h*0.5-str*0.5);
    endShape();

    beginShape();
    fill(shw1);
    vertex(x-w*0.5+str*0.5, y-h*0.5+str*0.5);
    vertex(x+w*0.5-str*0.5, y-h*0.5+str*0.5);
    fill(shw2);
    vertex(x+w*0.5-str*0.5-bb, y-h*0.5+str*0.5+bb);
    vertex(x-w*0.5+str*0.5, y-h*0.5+str*0.5+bb);
    endShape();
  }

  ArrayList<Interception> interception(Rect r2) {

    ArrayList<Interception> points = new ArrayList<Interception>();

    float r1x1 = x-w*0.5;
    float r1x2 = x+w*0.5;
    float r1y1 = y-h*0.5;
    float r1y2 = y+h*0.5;

    float r2x1 = r2.x-r2.w*0.5;
    float r2x2 = r2.x+r2.w*0.5;
    float r2y1 = r2.y-r2.h*0.5;
    float r2y2 = r2.y+r2.h*0.5;

    PVector p;

    p = lineLineIntersect(r1x1, r1y1, r1x2, r1y1, r2x1, r2y1, r2x1, r2y2);
    if (p != null) points.add(new Interception(p.copy(), this, r2));
    p = lineLineIntersect(r1x1, r1y1, r1x2, r1y1, r2x2, r2y1, r2x2, r2y2);
    if (p != null) points.add(new Interception(p.copy(), this, r2));

    p = lineLineIntersect(r1x1, r1y2, r1x2, r1y2, r2x1, r2y1, r2x1, r2y2);
    if (p != null) points.add(new Interception(p.copy(), this, r2));
    p = lineLineIntersect(r1x1, r1y2, r1x2, r1y2, r2x2, r2y1, r2x2, r2y2);
    if (p != null) points.add(new Interception(p.copy(), this, r2));

    if (points.size() <= 0) points = null;

    return points;
  }
}

PVector lineLineIntersect(float x1, float y1, float x2, float y2, float x3, float y3, float x4, float y4) {
  PVector p = null;

  if (abs(x3-x4) < 0.1) {

    float x = x3;
    float y = y1;

    if (x > min(x1, x2) && x < max(x1, x2) && y > min(y3, y4) && y < max(y3, y4)) {
      p = new PVector(x, y);
    }
  }
  return p;
}

void rectLine(float x1, float y1, float x2, float y2) {
  x1 += 0.5;
  y1 += 0.5;
  x2 += 0.5;
  y2 += 0.5;

  float cx = (x1+x2)*0.5;
  float cy = (y1+y2)*0.5;
  noFill();

  beginShape();
  vertex(x1, y1);
  if (abs(x1-x2) > abs(y1-y2)) {
    vertex(cx, y1);
    vertex(cx, y2);
  } else {
    vertex(x1, cy);
    vertex(x2, cy);
  }
  vertex(x2, y2);
  endShape();
}

boolean overlapRects(float x1, float y1, float x2, float y2, float x3, float y3, float x4, float y4) { 
  // If one rectangle is on left side of other 
  if (x1 > x4 || x3 > x2) 
    return false; 

  // If one rectangle is above other 
  if (y1 < y4 || y3 < x2) 
    return false; 

  return true;
} 
