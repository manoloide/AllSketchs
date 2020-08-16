int seed = int(random(999999));

void setup() {
  size(960, 540, P2D);
  smooth(8);
}

void draw() {

  noStroke();
  fill(0, 120);
  rect(0, 0, width, height);
  
  
  translate(width*0.5, height*0.5);

  float time = millis()*0.001*0.1;

  time = time-(time%1)+pow(time%1, 2);

  //time = time%1;

  ArrayList<Line> lines = new ArrayList<Line>();

  noiseSeed(seed);

  int count = 30;

  for (int i = 0; i < count; i++) {

    int i1 = (i+0)%count;
    int i2 = (i+1)%count;

    float x1 = (noise(i1, time)-0.5)*width*2.2;
    float y1 = (noise(time, i1)-0.5)*height*2.2;
    float x2 = (noise(i2, time)-0.5)*width*2.2;
    float y2 = (noise(time, i2)-0.5)*height*2.2;
    lines.add(new Line(x1, y1, x2, y2));
  }

  for (int i = 0; i < lines.size(); i++) {
    Line l = lines.get(i);
    l.show();
  }


  for (int i = 0; i < lines.size(); i++) {
    Line l1 = lines.get(i); 
    for (int j = 0; j < lines.size(); j++) {
      Line l2 = lines.get(j);

      PVector inter = lineLineIntersect(l1.x1, l1.y1, l1.x2, l1.y2, l2.x1, l2.y1, l2.x2, l2.y2);

      if (inter != null) {
        ellipse(inter.x, inter.y, 5, 5);
      }
    }
  }
}


void keyPressed() {
  seed = int(random(999999));
}

class Line {
  float x1, y1, x2, y2;
  Line(float x1, float y1, float x2, float y2) {
    this.x1 = x1; 
    this.y1 = y1;
    this.x2 = x2; 
    this.y2 = y2;
  }

  void show() {
    stroke(255);
    line(x1, y1, x2, y2);
  }
}

PVector lineLineIntersect(float x1, float y1, float x2, float y2, float x3, float y3, float x4, float y4 ) {
  PVector p = null;
  float a1 = y2 - y1;
  float b1 = x1 - x2;
  float c1 = a1*x1 + b1*y1;

  float a2 = y4 - y3;
  float b2 = x3 - x4;
  float c2 = a2*x3 + b2*y3;

  float det = a1*b2 - a2*b1;
  if (det == 0) {
  } else {
    float x = (b2*c1 - b1*c2)/det;
    float y = (a1*c2 - a2*c1)/det;

    if (x > min(x1, x2) && x < max(x1, x2) && 
      x > min(x3, x4) && x < max(x3, x4) &&
      y > min(y1, y2) && y < max(y1, y2) &&
      y > min(y3, y4) && y < max(y3, y4)) {
      p = new PVector(x, y);
    }
  }
  return p;
}
